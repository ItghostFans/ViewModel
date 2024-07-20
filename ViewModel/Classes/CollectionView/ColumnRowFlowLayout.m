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
        if (!CGRectEqualToRect(self.lastFrame, self.collectionView.frame)) {
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
    //    NSArray<__kindof NSIndexPath *> *indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems;
    //    for (NSUInteger section = _invalidateFromIndexPath.section; section < _viewModel.sectionViewModels.viewModels.count; ++section) {
    //        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
    //        NSUInteger itemCount = sectionViewModel.viewModels.count;
    //        for (NSUInteger item = 0; item < itemCount; ++item) {
    //            CellViewModel *cellViewModel = sectionViewModel[item];
    //            if (_invalidateFromIndexPath.section < section || (_invalidateFromIndexPath.section == section && _invalidateFromIndexPath.item <= item)) { // 变化后面的所有布局需要重新计算。
    //                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    //                if ([indexPathsForVisibleItems containsObject:indexPath]) {
    //                    [(CollectionViewModelCell *)[self.collectionView cellForItemAtIndexPath:indexPath] setViewModel:cellViewModel];
    //                }
    //            }
    //        }
    //    }
    NSArray<__kindof NSIndexPath *> *indexPathsForVisibleItems = self.collectionView.indexPathsForVisibleItems;
    for (NSIndexPath *indexPath in indexPathsForVisibleItems) {
        CellViewModel *cellViewModel = _viewModel.sectionViewModels[indexPath.section][indexPath.item];
        [(CollectionViewModelCell *)[self.collectionView cellForItemAtIndexPath:indexPath] setViewModel:cellViewModel];
    }
    _invalidateFromIndexPath = nil;
}

#pragma mark - Super

- (void)prepareLayout {
    NSAssert(_columnCount, @"%s Should Indicate Column Count!");
    NSAssert(_rowCount, @"%s Should Indicate Row Count!");
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
    return _shouldInvalidateLayoutForBoundsChange;
}

- (CGSize)collectionViewContentSize {
    if (!self.collectionView) {
        return CGSizeZero;
    }
    CGSize pageSize = self.collectionView.bounds.size;
    pageSize.height -= self.collectionView.contentInset.top + self.collectionView.contentInset.bottom;
    pageSize.width -= self.collectionView.contentInset.left + self.collectionView.contentInset.right;
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            return CGSizeMake(pageSize.width, pageSize.height * self.pageCount);
        }
    }
    return CGSizeMake(pageSize.width * self.pageCount, pageSize.height);
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
    for (NSUInteger section = 0; section < _viewModel.sectionViewModels.viewModels.count; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        NSUInteger itemCount = sectionViewModel.viewModels.count;
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
//                CGRect contentFrame =
//                CGRectMake(self.collectionView.contentOffset.x,
//                           self.collectionView.contentOffset.y,
//                           CGRectGetWidth(self.collectionView.bounds) - self.collectionView.contentInset.left - self.collectionView.contentInset.right,
//                           CGRectGetHeight(self.collectionView.bounds) - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
//                if (CGRectIntersectsRect(self.collectionView.bounds, attribute.frame)) {
//                }
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
//    NSAssert(_viewModel.sectionViewModels.viewModels.count == self.collectionView.numberOfSections, @"%s Sections Should Equal(%ld, %ld)!", __FUNCTION__, _viewModel.sectionViewModels.viewModels.count, self.collectionView.numberOfSections);
    for (NSUInteger section = 0; section < _viewModel.sectionViewModels.viewModels.count/*self.collectionView.numberOfSections*/; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        NSUInteger itemCount = sectionViewModel.viewModels.count; // [self.collectionView numberOfItemsInSection:section];
//        NSAssert(sectionViewModel.viewModels.count == itemCount, @"%s Sections Should Equal(%ld, %ld)!", __FUNCTION__, sectionViewModel.viewModels.count, itemCount);
        for (NSUInteger item = 0; item < itemCount; ++item) {
            CellViewModel *cellViewModel = sectionViewModel[item];
            if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                page += 1;
            }
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
//            [layoutAttributes addObject:attribute];
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
    CGFloat minimumInteritemSpacing = 0.0f;
    CGFloat minimumLineSpacing = 0.0f;
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            point.x = 0.0f;
            point.y = page * CGRectGetHeight(self.collectionView.bounds);
            minimumLineSpacing = sectionViewModel.collectionMinimumLineSpacing;
            minimumInteritemSpacing = sectionViewModel.collectionMinimumInteritemSpacing;
            break;
        }
        case UICollectionViewScrollDirectionHorizontal: {
            point.x = page * CGRectGetWidth(self.collectionView.bounds);
            point.y = 0.0f;
            minimumLineSpacing = sectionViewModel.collectionMinimumInteritemSpacing;
            minimumInteritemSpacing = sectionViewModel.collectionMinimumLineSpacing;
            break;
        }
        default: {
            break;
        }
    }
    
    point.x += (column) * (minimumInteritemSpacing + cellSize.width);
    point.y += (item % (_rowCount * _columnCount)) / _columnCount * (minimumLineSpacing + cellSize.height);
    
    return point;
}

- (CGSize)cellSizeOfViewModel:(CellViewModel *)viewModel {
    CGSize cellSize = [viewModel collectionCellSizeForSize:self.collectionView.bounds.size];
    if (CGSizeEqualToSize(cellSize, CGSizeZero)) {
        // TODO: Itghost 自动计算cellSize
    }
    return cellSize;
}

@end
