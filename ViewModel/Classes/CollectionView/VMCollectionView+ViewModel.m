//
//  VMCollectionView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/18.
//

#import "VMCollectionView+ViewModel.h"

#import <ViewModel/VMCollectionViewFlowLayout+ViewModel.h>
#import <VMOS/VMFoundation.h>

#import <objc/runtime.h>

@implementation VMCollectionView (ViewModel)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(performBatchUpdates:completion:) newSel:@selector(viewModel_performBatchUpdates:completion:) cls:self];
    });
}

- (void)performBatchUpdates:(void (^)(void))updates
                 completion:(void (^)(BOOL))completion
          animationsEnabled:(BOOL)animationsEnabled {
    void (^updateCompletion)(BOOL finished) = ^(BOOL finished) {
        if ([self.collectionViewLayout respondsToSelector:@selector(reloadIfNeed)]) {
            [(VMCollectionViewFlowLayout *)self.collectionViewLayout reloadIfNeed];
        }
        if (completion) {
            completion(finished);
        }
    };
    if (!animationsEnabled) {
#if TARGET_OS_IPHONE
        [VMView performWithoutAnimation:^{
            [self viewModel_performBatchUpdates:updates completion:updateCompletion];
        }];
#elif TARGET_OS_MAC
        [self viewModel_performBatchUpdates:updates completion:updateCompletion];
#endif // #if TARGET_OS_IPHONE
    } else {
        [self viewModel_performBatchUpdates:updates completion:updateCompletion];
    }
}

#pragma mark - Swizzled

- (void)viewModel_performBatchUpdates:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    BOOL animationsEnabled = YES;
    if (self.pagingEnabled) {               // 如果是pageEnabled的情况下，删除元素带动画，可能会导致complete的时候并不是按page展示。
        animationsEnabled = NO;
    }
    [self performBatchUpdates:updates completion:completion animationsEnabled:animationsEnabled];
}

@end
