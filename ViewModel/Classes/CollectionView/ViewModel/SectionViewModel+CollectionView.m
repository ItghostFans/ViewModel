//
//  SectionViewModel+CollectionView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "SectionViewModel.h"

#import <objc/runtime.h>

#import "WeakifyProxy.h"
#import "CollectionViewModel.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

@interface SectionViewModel ()

@property (strong, nonatomic, nonnull, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeHeaderSizes;
@property (strong, nonatomic, nonnull, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeFooterSizes;

@end

@implementation SectionViewModel (CollectionView)

- (NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *)sizeHeaderSizes {
    NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeHeaderSizes = objc_getAssociatedObject(self, @selector(sizeHeaderSizes));
    if (sizeHeaderSizes) {
        sizeHeaderSizes = NSMutableDictionary.new;
        objc_setAssociatedObject(self, @selector(sizeHeaderSizes), sizeHeaderSizes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sizeHeaderSizes;
}

- (NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *)sizeFooterSizes {
    NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeFooterSizes = objc_getAssociatedObject(self, @selector(sizeFooterSizes));
    if (sizeFooterSizes) {
        sizeFooterSizes = NSMutableDictionary.new;
        objc_setAssociatedObject(self, @selector(sizeFooterSizes), sizeFooterSizes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sizeFooterSizes;
}

#pragma mark - ICollectionSectionViewModel

- (NSUInteger)collectionSectionIndex {
    return [self.collectionViewModel.sectionViewModels indexOfViewModel:self];
}

- (CollectionViewModel *)collectionViewModel {
    return [objc_getAssociatedObject(self, @selector(collectionViewModel)) target];
}

- (void)setCollectionViewModel:(CollectionViewModel *)collectionViewModel {
    objc_setAssociatedObject(self, @selector(collectionViewModel), [[WeakifyProxy alloc] initWithTarget:collectionViewModel], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)collectionMinimumLineSpacing {
    return [objc_getAssociatedObject(self, @selector(collectionMinimumLineSpacing)) doubleValue];
}

- (void)setCollectionMinimumLineSpacing:(CGFloat)collectionMinimumLineSpacing {
    objc_setAssociatedObject(self, @selector(collectionMinimumLineSpacing), @(collectionMinimumLineSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)collectionMinimumInteritemSpacing {
    return [objc_getAssociatedObject(self, @selector(collectionMinimumInteritemSpacing)) doubleValue];
}

- (void)setCollectionMinimumInteritemSpacing:(CGFloat)collectionMinimumInteritemSpacing {
    objc_setAssociatedObject(self, @selector(collectionMinimumInteritemSpacing), @(collectionMinimumInteritemSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)collectionHeaderClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionFooterView.class;
}

- (CGSize)collectionHeaderSizeForSize:(CGSize)size {
    NSValue *headerSize;
    @synchronized (self.sizeHeaderSizes) {
        NSValue *collectionViewSize = [NSValue valueWithCGSize:size];
        headerSize = self.sizeHeaderSizes[collectionViewSize];
        if (!headerSize) {
            CGSize contentSize = size;
            headerSize = [NSValue valueWithCGSize:[self.collectionHeaderClass headerSizeForSize:&contentSize viewModel:self]];
            self.sizeHeaderSizes[collectionViewSize] = headerSize;
        }
    }
    return headerSize.CGSizeValue;
}

- (CGSize)collectionFooterSizeForSize:(CGSize)size {
    NSValue *footerSize;
    @synchronized (self.sizeFooterSizes) {
        NSValue *collectionViewSize = [NSValue valueWithCGSize:size];
        footerSize = self.sizeFooterSizes[collectionViewSize];
        if (!footerSize) {
            CGSize contentSize = size;
            footerSize = [NSValue valueWithCGSize:[self.collectionFooterClass footerSizeForSize:&contentSize viewModel:self]];
            self.sizeFooterSizes[collectionViewSize] = footerSize;
        }
    }
    return footerSize.CGSizeValue;
}

@end
