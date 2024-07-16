//
//  ColumnRowFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import "ColumnRowFlowLayout.h"
#import "CellViewModel+CollectionView.h"
#import "SectionViewModel+CollectionView.h"

typedef NSMutableDictionary<__kindof NSIndexPath *, __kindof UICollectionViewLayoutAttributes *> ItemLayoutAttributes;
typedef NSMutableDictionary<__kindof NSNumber *, __kindof UICollectionViewLayoutAttributes *> SectionLayoutAttributes;

@interface ColumnRowFlowLayout ()

@property (assign, nonatomic) BOOL shouldInvalidateLayoutForBoundsChange;
@property (strong, nonatomic) ItemLayoutAttributes *itemLayoutAttributes;
@property (strong, nonatomic) SectionLayoutAttributes *sectionHeaderLayoutAttributes;
@property (strong, nonatomic) SectionLayoutAttributes *sectionFooterLayoutAttributes;

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
    _viewModel = viewModel;
    NSAssert(self.collectionView, @"Should Set CollectionViewLayout First!");
    NSAssert(CGRectIsEmpty(self.collectionView.frame), @"Should Layout CollectionView First!");
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

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        NSUInteger targetSection = updateItem.indexPathAfterUpdate.section;
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionMove: {
                targetSection = updateItem.indexPathBeforeUpdate.section;
            }
            case UICollectionUpdateActionInsert: {
                NSUInteger page = 0;
                for (NSUInteger section = 0; section < _viewModel.sectionViewModels.viewModels.count; ++section) {
                    SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
                    NSUInteger itemCount = sectionViewModel.viewModels.count;
                    for (NSUInteger item = 0; item < itemCount; ++item) {
                        CellViewModel *cellViewModel = sectionViewModel[item];
                        if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                            page += 1;
                        }
                        if (targetSection <= section) { // 变化后面的所有布局需要重新计算。
                            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
                            CGPoint point = [self pointOfItem:item section:section page:page];
                            CGSize cellSize = [self cellSizeOfViewModel:cellViewModel];
                            attribute.frame = CGRectMake(point.x, point.y, cellSize.width, cellSize.height);
                        }
                    }
                    if (itemCount > 0) {
                        page += 1;
                    }
                }
                break;
            }
            case UICollectionUpdateActionDelete: {
                break;
            }
            case UICollectionUpdateActionReload: {
                break;
            }
            default: {
                break;
            }
        }
    }
}

- (void)finalizeCollectionViewUpdates {
    // TODO: Remove all initialLayoutAttributes
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
    
    point.x += (column + 1) * (minimumInteritemSpacing + cellSize.width) - cellSize.width;
    point.y += (item % (_rowCount * _columnCount)) / _columnCount * (minimumLineSpacing + cellSize.height) + minimumLineSpacing;
    
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
