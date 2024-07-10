//
//  UITableView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/10.
//

#import "UITableView+ViewModel.h"

#import <objc/runtime.h>

@interface UITableView ()
@property (assign, nonatomic) UITableViewRowAnimation rowAnimation;
@end

@implementation UITableView (ViewModel)

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
    self.rowAnimation = UITableViewRowAnimationNone;
    [self viewModel_performBatchUpdates:updates completion:completion];
}

#pragma mark - Public

- (void)performBatchUpdates:(void (^)(void))updates
               rowAnimation:(UITableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL))completion {
    self.rowAnimation = rowAnimation;
    [self viewModel_performBatchUpdates:updates completion:completion];
}

#pragma mark - Property

- (UITableViewRowAnimation)rowAnimation {
    return [objc_getAssociatedObject(self, @selector(rowAnimation)) integerValue];
}

- (void)setRowAnimation:(UITableViewRowAnimation)rowAnimation {
    objc_setAssociatedObject(self, @selector(rowAnimation), @(rowAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
