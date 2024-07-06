//
//  CellViewModel+CollectionView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

#import <objc/runtime.h>

#import "WeakifyProxy.h"
#import "CollectionViewModel.h"
#import "CollectionViewModelCell.h"
#import "SectionViewModel+CollectionView.h"

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
    NSUInteger section = [self.collectionSectionViewModel.viewModels indexOfObject:self];
    if (section == NSNotFound) {
        return nil;
    }
    SectionViewModel *sectionViewModel = self.collectionSectionViewModel[section];
    NSUInteger item = [sectionViewModel.viewModels indexOfObject:self];
    if (item == NSNotFound) {
        return nil;
    }
    return [NSIndexPath indexPathForItem:item inSection:section];
}

- (Class)collectionCellClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionViewModelCell.class;
}

- (SectionViewModel *)collectionSectionViewModel {
    return [objc_getAssociatedObject(self, @selector(collectionSectionViewModel)) target];
}

- (void)setCollectionSectionViewModel:(SectionViewModel *)collectionSectionViewModel {
    objc_setAssociatedObject(self, @selector(collectionSectionViewModel), [[WeakifyProxy alloc] initWithTarget:collectionSectionViewModel], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
