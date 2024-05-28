//
//  CellViewModel+CollectionView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

#import <objc/runtime.h>

#import "CollectionViewModelCell.h"

@interface CellViewModel ()

@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeCellSizes;

@property (assign, nonatomic) CGSize collectionCellSize;               // 最后一次collectionCellSizeForSize:的size。

@end

@implementation CellViewModel (CollectionView)

- (NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *)sizeCellSizes {
    NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeCellSizes = objc_getAssociatedObject(self, @selector(sizeCellSizes));
    if (sizeCellSizes) {
        sizeCellSizes = NSMutableDictionary.new;
        objc_setAssociatedObject(self, @selector(sizeCellSizes), sizeCellSizes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sizeCellSizes;
}

#pragma mark - ICollectionCellViewModel

- (void)setCollectionIndexPath:(NSIndexPath *)collectionIndexPath {
    objc_setAssociatedObject(self, @selector(collectionIndexPath), collectionIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)collectionIndexPath {
    return objc_getAssociatedObject(self, @selector(collectionIndexPath));
}

- (CGSize)collectionCellSize {
    NSValue *collectionCellSize = objc_getAssociatedObject(self, @selector(collectionCellSize));
    return [collectionCellSize CGSizeValue];
}

- (void)setCollectionCellSize:(CGSize)collectionCellSize {
    objc_setAssociatedObject(self, @selector(collectionCellSize), [NSValue valueWithCGSize:collectionCellSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)collectionCellClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionViewModelCell.class;
}

- (CGSize)collectionCellSizeForSize:(CGSize)size {
    NSValue *cellSize;
    @synchronized (self.sizeCellSizes) {
        NSValue *collectionViewSize = [NSValue valueWithCGSize:size];
        cellSize = self.sizeCellSizes[collectionViewSize];
        if (!cellSize) {
            CGSize contentSize = size;
            cellSize = [NSValue valueWithCGSize:[self.collectionCellClass cellSizeForSize:&contentSize viewModel:self]];
            self.sizeCellSizes[collectionViewSize] = cellSize;
            self.collectionCellSize = cellSize.CGSizeValue;
        }
    }
    return cellSize.CGSizeValue;
}

@end
