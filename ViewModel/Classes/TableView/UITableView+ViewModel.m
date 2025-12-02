//
//  UITableView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/10.
//

#import "UITableView+ViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ViewModel/TableViewModelCell.h>
#import <ViewModel/TableViewModel+UITableViewModelDataSource.h>

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

- (void)viewModel_performBatchUpdates:(void (^)(void))updates completion:(void (^)(BOOL finished))completion {
    @weakify(self);
    self.rowAnimation = UITableViewRowAnimationNone;
    [self viewModel_performBatchUpdates:updates completion:^(BOOL finished) {
        @strongify(self);
        [self reloadIfNeed];
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - Public

- (void)performBatchUpdates:(void (^)(void))updates
               rowAnimation:(UITableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL finished))completion {
    @weakify(self);
    self.rowAnimation = rowAnimation;
    if (self.rowAnimation == UITableViewRowAnimationNone) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
    }
    [self viewModel_performBatchUpdates:updates completion:^(BOOL finished) {
        @strongify(self);
        [self reloadIfNeed];
        if (completion) {
            completion(finished);
        }
    }];
    if (self.rowAnimation == UITableViewRowAnimationNone) {
        [CATransaction commit];
    }
}

#pragma mark - Property

- (UITableViewRowAnimation)rowAnimation {
    return [objc_getAssociatedObject(self, @selector(rowAnimation)) integerValue];
}

- (void)setRowAnimation:(UITableViewRowAnimation)rowAnimation {
    objc_setAssociatedObject(self, @selector(rowAnimation), @(rowAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Layout

- (void)reloadIfNeed {
    NSArray<__kindof NSIndexPath *> *indexPathsForVisibleRows = self.indexPathsForVisibleRows;
    if ([self.dataSource respondsToSelector:@selector(tableView:cellViewModelForIndexPath:)]) {
        for (NSIndexPath *indexPath in indexPathsForVisibleRows) {
            CellViewModel *cellViewModel = [(id<UITableViewModelDataSource>)self.dataSource tableView:self cellViewModelForIndexPath:indexPath];
            [(TableViewModelCell *)[self cellForRowAtIndexPath:indexPath] setViewModel:cellViewModel];
        }
    }
}

@end
