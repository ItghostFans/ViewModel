//
//  CollectionFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import "CollectionFlowLayout.h"

@interface CollectionFlowLayout ()

@property (assign, nonatomic) BOOL shouldInvalidateLayoutForBoundsChange;

@end

@implementation CollectionFlowLayout

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
    // TODO: Itghost 根据对应区域，返回需要处理的layoutAttributes
    return @[];
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
    // TODO: Itghost 计算出有效大小
    return CGSizeMake(0.0f, 0.0f);
}

@end
