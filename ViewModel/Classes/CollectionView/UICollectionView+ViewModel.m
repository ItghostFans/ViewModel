//
//  UICollectionView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/18.
//

#import "UICollectionView+ViewModel.h"

#import <ViewModel/UICollectionViewFlowLayout+ViewModel.h>
#import <VMOS/VMFoundation.h>

#import <objc/runtime.h>

@implementation UICollectionView (ViewModel)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(performBatchUpdates:completion:) newSel:@selector(viewModel_performBatchUpdates:completion:) cls:self];
    });
}

- (void)performBatchUpdates:(void (^)(void))updates
                 completion:(void (^)(BOOL))completion
          animationsEnabled:(BOOL)animationsEnabled {
    if (!animationsEnabled) {
        [UIView setAnimationsEnabled:animationsEnabled];
    }
    [self viewModel_performBatchUpdates:updates completion:^(BOOL finished) {
        if ([self.collectionViewLayout respondsToSelector:@selector(reloadIfNeed)]) {
            [(UICollectionViewFlowLayout *)self.collectionViewLayout reloadIfNeed];
        }
        if (!animationsEnabled) {
            [UIView setAnimationsEnabled:YES];
        }
        if (completion) {
            completion(finished);
        }
    }];
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
