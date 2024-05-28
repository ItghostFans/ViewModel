//
//  SectionViewModel+CollectionView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "SectionViewModel.h"

#import <objc/runtime.h>

#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

@interface SectionViewModel ()

@property (strong, nonatomic, nonnull, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeHeaderSizes;
@property (strong, nonatomic, nonnull, readonly) NSMutableDictionary<__kindof NSValue *, __kindof NSValue *> *sizeFooterSizes;

@property (assign, nonatomic) CGSize collectionHeaderSize;               // 最后一次collectionHeaderSizeForSize:的size。
@property (assign, nonatomic) CGSize collectionFooterSize;               // 最后一次collectionFooterSizeForSize:的size。

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

- (void)setCollectionIndexPath:(NSIndexPath *)collectionIndexPath {
    objc_setAssociatedObject(self, @selector(collectionIndexPath), collectionIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)collectionIndexPath {
    return objc_getAssociatedObject(self, @selector(collectionIndexPath));
}

- (CGSize)collectionHeaderSize {
    NSValue *collectionHeaderSize = objc_getAssociatedObject(self, @selector(collectionHeaderSize));
    return [collectionHeaderSize CGSizeValue];
}

- (void)setCollectionHeaderSize:(CGSize)collectionHeaderSize {
    objc_setAssociatedObject(self, @selector(collectionHeaderSize), [NSValue valueWithCGSize:collectionHeaderSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)collectionFooterSize {
    NSValue *collectionFooterSize = objc_getAssociatedObject(self, @selector(collectionFooterSize));
    return [collectionFooterSize CGSizeValue];
}

- (void)setCollectionFooterSize:(CGSize)collectionFooterSize {
    objc_setAssociatedObject(self, @selector(collectionFooterSize), [NSValue valueWithCGSize:collectionFooterSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
            self.collectionHeaderSize = headerSize.CGSizeValue;
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
            self.collectionFooterSize = footerSize.CGSizeValue;
        }
    }
    return footerSize.CGSizeValue;
}

@end
