//
//  UICollectionView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/18.
//

#import "UICollectionView+ViewModel.h"
#import "UICollectionViewFlowLayout+ViewModel.h"

#import <objc/runtime.h>

@implementation UICollectionView (ViewModel)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(self, @selector(performBatchUpdates:completion:));
        Method currentMethod = class_getInstanceMethod(self, @selector(viewModel_performBatchUpdates:completion:));
        method_exchangeImplementations(oldMethod, currentMethod);
    });
}

#pragma mark - Swizzled


- (void)viewModel_performBatchUpdates:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    [self viewModel_performBatchUpdates:updates completion:^(BOOL finished) {
        if ([self.collectionViewLayout respondsToSelector:@selector(reloadIfNeed)]) {
            [(UICollectionViewFlowLayout *)self.collectionViewLayout reloadIfNeed];
        }
        if (completion) {
            completion(finished);
        }
    }];
}

@end
