//
//  ColumnRowFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import "ColumnRowFlowLayout.h"
#import "CellViewModel+CollectionView.h"
#import "SectionViewModel+CollectionView.h"

@interface ColumnRowFlowLayout ()

@property (assign, nonatomic) BOOL shouldInvalidateLayoutForBoundsChange;

@end

@implementation ColumnRowFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        _shouldInvalidateLayoutForBoundsChange = YES;
    }
    return self;
}

#pragma mark - Super

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (!self.collectionView || !_viewModel) {
        return nil;
    }
    NSMutableArray *layoutAttributes = NSMutableArray.new;
    NSUInteger page = 0;
    NSAssert(_viewModel.sectionViewModels.viewModels.count == self.collectionView.numberOfSections, @"%s Sections Should Equal(%ld, %ld)!", __FUNCTION__, _viewModel.sectionViewModels.viewModels.count, self.collectionView.numberOfSections);
    for (NSUInteger section = 0; section < self.collectionView.numberOfSections; ++section) {
        SectionViewModel *sectionViewModel = _viewModel.sectionViewModels[section];
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSAssert(sectionViewModel.viewModels.count == itemCount, @"%s Sections Should Equal(%ld, %ld)!", __FUNCTION__, sectionViewModel.viewModels.count, itemCount);
        for (NSUInteger item = 0; item < itemCount; ++item) {
            CellViewModel *cellViewModel = sectionViewModel[item];
            if (item > 0 && (item % (_columnCount * _rowCount) == 0)) {
                page += 1;
            }
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            [layoutAttributes addObject:attribute];
            CGPoint point = [self pointOfItem:item section:section page:page];
            CGSize cellSize = [cellViewModel collectionCellSizeForSize:self.collectionView.bounds.size];
            attribute.frame = CGRectMake(point.x, point.y, cellSize.width, cellSize.height);
        }
        if (itemCount > 0) {
            page += 1;
        }
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
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
    return CGSizeMake(pageSize.width * self.pageCount, pageSize.height);
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
    CGSize cellSize = [cellViewModel collectionCellSizeForSize:self.collectionView.bounds.size];
    NSUInteger column = item % _columnCount;
    CGPoint point = CGPointZero;
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            point.x = 0.0f;
            point.y = page * CGRectGetHeight(self.collectionView.frame);
            break;
        }
        case UICollectionViewScrollDirectionHorizontal: {
            point.x = page * CGRectGetWidth(self.collectionView.frame);
            point.y = 0.0f;
            
            point.x += (column + 1) * (sectionViewModel.collectionMinimumLineSpacing + cellSize.width) - cellSize.width;
            point.y += (item % (_rowCount * _columnCount)) / _columnCount * (sectionViewModel.collectionMinimumInteritemSpacing + cellSize.height) + sectionViewModel.collectionMinimumInteritemSpacing;
            break;
        }
        default: {
            break;
        }
    }
    
    return point;
}

@end
