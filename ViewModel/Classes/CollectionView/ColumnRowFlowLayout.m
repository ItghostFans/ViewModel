//
//  ColumnRowFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import "ColumnRowFlowLayout.h"
#import "CellViewModel+CollectionView.h"
#import "SectionViewModel+CollectionView.h"
#import "CollectionViewModelCell.h"

#import <ReactiveObjC/ReactiveObjC.h>

typedef NSMutableDictionary<__kindof NSIndexPath *, __kindof UICollectionViewLayoutAttributes *> ItemLayoutAttributes;
typedef NSMutableDictionary<__kindof NSNumber *, __kindof UICollectionViewLayoutAttributes *> SectionLayoutAttributes;

@interface ColumnRowFlowLayout ()

@property (assign, nonatomic) BOOL shouldInvalidateLayoutForBoundsChange;
@property (strong, nonatomic) ItemLayoutAttributes *itemLayoutAttributes;
@property (strong, nonatomic) SectionLayoutAttributes *sectionHeaderLayoutAttributes;
@property (strong, nonatomic) SectionLayoutAttributes *sectionFooterLayoutAttributes;

@property (strong, nonatomic) NSIndexPath *invalidateFromIndexPath;

@property (strong, nonatomic, nullable) RACCompoundDisposable *disposableBag;
@property (assign, nonatomic) CGRect lastFrame;
@property (assign, nonatomic) CGSize cellSize;

@end

@implementation ColumnRowFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        _shouldInvalidateLayoutForBoundsChange = YES;
        _itemLayoutAttributes = NSMutableDictionary.new;
        _sectionHeaderLayoutAttributes = NSMutableDictionary.new;
        _sectionFooterLayoutAttributes = NSMutableDictionary.new;
    }
    return self;
}

- (void)setViewModel:(CollectionViewModel *)viewModel {
    if (_disposableBag) {
        [_disposableBag dispose];
    }
    if (viewModel) {
        _disposableBag = RACCompoundDisposable.new;
    }
    _viewModel = viewModel;
    [self.collectionView.superview layoutIfNeeded];
    NSAssert(self.collectionView, @"Should Set CollectionViewLayout First!");
    NSAssert(!CGRectIsEmpty(self.collectionView.frame), @"Should Layout CollectionView First!");
    @weakify(self);
    [self relayoutAllAttributes];
    RACDisposable *disposable = [[self.collectionView rac_signalForSelector:@selector(layoutSubviews)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if (!CGRectEqualToRect(self.lastFrame, self.collectionView.frame) || !CGPointEqualToPoint(self.lastFrame.origin, self.collectionView.frame.origin)) {
            [self relayoutAllAttributes];
            [self invalidateLayout];
            self.lastFrame = self.collectionView.frame;
        }
    }];
    [_disposableBag addDisposable:disposable];
}

- (void)reloadIfNeed {
    if (!_invalidateFromIndexPath) {
        return;
    }
    // 只更新可见区域的即可。
    NSArray<__kindof NSIndexPath *> *indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems;
    for (NSIndexPath *indexPath in indexPathsForVisibleItems) {
        CellViewModel *cellViewModel = _viewModel.sectionViewModels[indexPath.section][indexPath.item];
        [(CollectionViewModelCell *)[self.collectionView cellForItemAtIndexPath:indexPath] setViewModel:cellViewModel];
    }
    _invalidateFromIndexPath = nil;
}

#pragma mark - Super

- (void)prepareLayout {
    NSAssert(_columnCount || _rowCount, @"%s Should Indicate Column Count Or !");
    if (self.collectionView.pagingEnabled) {
        NSAssert(UIEdgeInsetsEqualToEdgeInsets(self.collectionView.contentInset, UIEdgeInsetsZero), @"UICollectionView.pagingEnabled Should contentInset == UIEdgeInsetsZero!");
    }
    [super prepareLayout];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (!self.collectionView || !_viewModel) {
        return nil;
    }
    NSMutableArray *layoutAttributes = NSMutableArray.new;
    [layoutAttributes addObjectsFromArray:_itemLayoutAttributes.allValues];
    [layoutAttributes addObjectsFromArray:_sectionHeaderLayoutAttributes.allValues];
    [layoutAttributes addObjectsFromArray:_sectionFooterLayoutAttributes.allValues];
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = _itemLayoutAttributes[indexPath];
    if (!attribute) {
        attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        _itemLayoutAttributes[indexPath] = attribute;
    }
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        _sectionHeaderLayoutAttributes[indexPath];
        if (!attribute) {
            attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            _sectionHeaderLayoutAttributes[indexPath] = attribute;
        }
    } else
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        _sectionFooterLayoutAttributes[indexPath];
        if (!attribute) {
            attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            _sectionFooterLayoutAttributes[indexPath] = attribute;
        }
    }
    return attribute;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (_shouldInvalidateLayoutForBoundsChange) {
        return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    }
    return NO;
}

- (CGSize)collectionViewContentSize {
    if (!self.collectionView) {
        return CGSizeZero;
    }
    if (self.collectionView.pagingEnabled) {
        CGSize pageSize = self.pageSize;
        pageSize.height -= self.collectionView.contentInset.top + self.collectionView.contentInset.bottom;
        pageSize.width -= self.collectionView.contentInset.left + self.collectionView.contentInset.right;
        switch (self.scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                return CGSizeMake(pageSize.width, pageSize.height * self.pageCount);
            }
        }
        return CGSizeMake(pageSize.width * self.pageCount, pageSize.height);
    }
    NSUInteger itemCount = 0;
    for (NSUInteger section = 0; section < _viewModel.sectionViewModels.count; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        itemCount += sectionViewModel.count;
    }
    NSUInteger rowCount = _rowCount;
    NSUInteger columnCount = _columnCount;
    if (_columnCount) {
        rowCount = (itemCount + _columnCount - 1) / _columnCount;
    }
    if (_rowCount) {
        columnCount = (itemCount + _rowCount - 1) / _rowCount;
    }
    CGSize contentSize;
    CGFloat minimumInteritemSpacing = 0.0f; // Cell左右间距
    CGFloat minimumLineSpacing = 0.0f;      // Cell上下间距
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            minimumLineSpacing = self.minimumLineSpacing;
            minimumInteritemSpacing = self.minimumInteritemSpacing;
            break;
        }
        case UICollectionViewScrollDirectionHorizontal: {
            minimumLineSpacing = self.minimumInteritemSpacing;
            minimumInteritemSpacing = self.minimumLineSpacing;
            break;
        }
        default: {
            break;
        }
    }
    contentSize.width = (columnCount * (self.cellSize.width + minimumInteritemSpacing)) - minimumInteritemSpacing + self.contentInset.left + self.contentInset.right;
    contentSize.height = (rowCount * (self.cellSize.height + minimumLineSpacing)) - minimumLineSpacing + self.contentInset.top + self.contentInset.bottom;
}

#define ASSIGN_IF_LARGE_THAN(value, left) \
    left = !left ? value : [left compare:value] == NSOrderedDescending ? value : left;

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionMove: {
                ASSIGN_IF_LARGE_THAN(updateItem.indexPathBeforeUpdate, _invalidateFromIndexPath);
                break;
            }
            case UICollectionUpdateActionInsert: {
                if (updateItem.indexPathAfterUpdate.item == NSNotFound) {
                    ASSIGN_IF_LARGE_THAN([NSIndexPath indexPathForItem:0 inSection:updateItem.indexPathAfterUpdate.section], _invalidateFromIndexPath);
                } else {
                    ASSIGN_IF_LARGE_THAN(updateItem.indexPathAfterUpdate, _invalidateFromIndexPath);
                }
                break;
            }
            case UICollectionUpdateActionDelete: {  // 之前的可以复用。
                ASSIGN_IF_LARGE_THAN(updateItem.indexPathBeforeUpdate, _invalidateFromIndexPath);
                break;
            }
            case UICollectionUpdateActionReload: {
                _invalidateFromIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                break;
            }
            default: {
                break;
            }
        }
    }
    
    NSUInteger page = 0;
    for (NSUInteger section = 0; section < _viewModel.sectionViewModels.count; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        NSUInteger itemCount = sectionViewModel.count;
        for (NSUInteger item = 0; item < itemCount; ++item) {
            CellViewModel *cellViewModel = sectionViewModel[item];
            if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                page += 1;
            }
            if (_invalidateFromIndexPath.section < section || 
                (_invalidateFromIndexPath.section == section && _invalidateFromIndexPath.item <= item)) { // 变化后面的所有布局需要重新计算。
                UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
                CGSize cellSize = [self cellSizeOfViewModel:cellViewModel];
                CGPoint point = [self pointOfItem:item section:section page:page];
                attribute.frame = CGRectMake(point.x, point.y, cellSize.width, cellSize.height);
            }
        }
        if (itemCount > 0) {
            page += 1;
        }
    }
}

- (void)finalizeCollectionViewUpdates {
    // TODO: Remove all initialLayoutAttributes
}

- (void)finalizeLayoutTransition {
    [super finalizeLayoutTransition];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind
                                                                                        atIndexPath:(NSIndexPath *)elementIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind
                                                                                         atIndexPath:(NSIndexPath *)elementIndexPath {
    return nil;
}

#pragma mark - Layout

- (void)relayoutAllAttributes {
    // Item.
    NSUInteger page = 0;
    for (NSUInteger section = 0; section < _viewModel.sectionViewModels.count/*self.collectionView.numberOfSections*/; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        NSUInteger itemCount = sectionViewModel.count; // [self.collectionView numberOfItemsInSection:section];
        for (NSUInteger item = 0; item < itemCount; ++item) {
            CellViewModel *cellViewModel = sectionViewModel[item];
            if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                page += 1;
            }
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            CGPoint point = [self pointOfItem:item section:section page:page];
            CGSize cellSize = [self cellSizeOfViewModel:cellViewModel];
            attribute.frame = CGRectMake(point.x, point.y, cellSize.width, cellSize.height);
        }
        if (itemCount > 0) {
            page += 1;
        }
    }
}

- (NSUInteger)pageCount {
    NSUInteger pageCount = 0;
    for (NSUInteger section = 0; section < self.collectionView.numberOfSections; ++section) {
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for (NSUInteger item = 0; item < itemCount; ++item) {
            if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                pageCount += 1;
            }
        }
        if (itemCount > 0) {
            pageCount += 1;
        }
    }
    return pageCount;
}

- (CGPoint)pointOfItem:(NSUInteger)item section:(NSUInteger)section page:(NSUInteger)page {
    SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
    CellViewModel *cellViewModel = sectionViewModel[item];
    CGSize cellSize = [self cellSizeOfViewModel:cellViewModel];
    NSUInteger column = item % _columnCount;
    CGPoint point = CGPointZero;
    CGFloat minimumInteritemSpacing = 0.0f; // Cell左右间距
    CGFloat minimumLineSpacing = 0.0f;      // Cell上下间距
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            point.x = self.contentInset.left;
            point.y = page * self.pageSize.height + self.contentInset.top;
            minimumLineSpacing = self.minimumLineSpacing;
            minimumInteritemSpacing = self.minimumInteritemSpacing;
            break;
        }
        case UICollectionViewScrollDirectionHorizontal: {
            point.x = page * self.pageSize.width + self.contentInset.left;
            point.y = self.contentInset.top;
            minimumLineSpacing = self.minimumInteritemSpacing;
            minimumInteritemSpacing = self.minimumLineSpacing;
            break;
        }
        default: {
            break;
        }
    }
    if (self.collectionView.pagingEnabled) {
        point.x += (column) * (minimumInteritemSpacing + cellSize.width);
        point.y += (item % (_rowCount * _columnCount)) / _columnCount * (minimumLineSpacing + cellSize.height);
    } else {
        NSUInteger itemIndex = item;
        for (NSUInteger index = 0; index < section; ++index) {
            SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
            itemIndex += sectionViewModel.count;
        }
        NSUInteger rowIndex = 0;
        NSUInteger columnIndex = 0;
        if (_columnCount) {
            columnIndex = itemIndex % _columnCount;
            rowIndex = itemIndex / _columnCount;
        }
        if (_rowCount) {
            rowIndex = itemIndex % _rowCount;
            columnIndex = itemIndex / _rowCount;
        }
        point.x = (columnIndex * (minimumInteritemSpacing + cellSize.width)) + self.contentInset.left;
        point.y = (rowIndex * (minimumLineSpacing + cellSize.width)) + self.contentInset.top;
    }
    
    return point;
}

- (CGSize)cellSizeOfViewModel:(CellViewModel *)viewModel {
    CGSize cellSize = [viewModel collectionCellSizeForSize:self.pageSize];
    if (CGSizeEqualToSize(cellSize, CGSizeZero)) {
        cellSize = self.cellSize;
    }
    if (CGSizeEqualToSize(cellSize, CGSizeZero)) {
        CGFloat width = self.pageSize.width;
        CGFloat height = self.pageSize.height;
        SectionViewModel *sectionViewModel = viewModel.collectionSectionViewModel;
        CGFloat minimumInteritemSpacing = 0.0f; // Cell左右间距
        CGFloat minimumLineSpacing = 0.0f;      // Cell上下间距
        switch (self.scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                minimumLineSpacing = self.minimumLineSpacing;
                minimumInteritemSpacing = self.minimumInteritemSpacing;
                break;
            }
            case UICollectionViewScrollDirectionHorizontal: {
                minimumLineSpacing = self.minimumInteritemSpacing;
                minimumInteritemSpacing = self.minimumLineSpacing;
                break;
            }
            default: {
                break;
            }
        }
        if (_columnCount) {
            cellSize.width = MAX((width - ((_columnCount - 1) * minimumInteritemSpacing) - self.contentInset.left - self.contentInset.right) / _columnCount, 0.0f);
        }
        if (_rowCount) {
            cellSize.height = MAX((height - ((_rowCount - 1) * minimumLineSpacing) - self.contentInset.top - self.contentInset.bottom) / _rowCount, 0.0f);
        }
        if (cellSize.width == 0.0f) {
            cellSize.width = cellSize.height;
        }
        if (cellSize.height == 0.0f) {
            cellSize.height = cellSize.width;
        }
        self.cellSize = cellSize;
    }
    return cellSize;
}

- (CGSize)pageSize {
    CGRect pageFrame = CGRectIntersection(self.collectionView.bounds, CGRectMake(0.0f, 0.0f, CGFLOAT_MAX, CGFLOAT_MAX));
    return pageFrame.size;
}

@end
