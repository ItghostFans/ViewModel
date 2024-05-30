//
//  CellViewModel+CollectionView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

#import <objc/runtime.h>

#import "WeakifyProxy.h"
#import "CollectionViewModel.h"
#import "CollectionViewModelCell.h"

@interface CellViewModel ()

@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeCellSizes;

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

- (NSIndexPath *)collectionIndexPath {
    for (NSUInteger section = 0; section < self.collectionViewModel.sectionViewModels.viewModels.count; ++section) {
        SectionViewModel *sectionViewModel = self.collectionViewModel.sectionViewModels.viewModels[section];
        for (NSUInteger item = 0; item < sectionViewModel.viewModels.count; ++item) {
            CellViewModel *cellViewModel = sectionViewModel.viewModels[item];
            if (cellViewModel == self) {
                return [NSIndexPath indexPathForItem:item inSection:section];
            }
        }
    }
    return nil;
}

- (Class)collectionCellClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionViewModelCell.class;
}

- (CollectionViewModel *)collectionViewModel {
    return [objc_getAssociatedObject(self, @selector(collectionViewModel)) target];
}

- (void)setCollectionViewModel:(CollectionViewModel *)collectionViewModel {
    objc_setAssociatedObject(self, @selector(collectionViewModel), [[WeakifyProxy alloc] initWithTarget:collectionViewModel], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
        }
    }
    return cellSize.CGSizeValue;
}

@end
