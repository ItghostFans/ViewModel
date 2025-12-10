//
//  VMTableView+ViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/10.
//

#import "VMTableView+ViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ViewModel/TableViewModelCell.h>
#import <ViewModel/TableViewModel+ITableViewModelDataSource.h>

#import <objc/runtime.h>

@interface VMTableView ()
@property (assign, nonatomic) VMTableViewRowAnimation rowAnimation;
@end

@implementation VMTableView (ViewModel)

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
    self.rowAnimation = VMTableViewRowAnimationNone;
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
               rowAnimation:(VMTableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL finished))completion {
    @weakify(self);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
    self.rowAnimation = rowAnimation;
#pragma clang diagnostic pop
    if (self.rowAnimation == VMTableViewRowAnimationNone) {
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
    if (self.rowAnimation == VMTableViewRowAnimationNone) {
        [CATransaction commit];
    }
}

#pragma mark - Property

- (VMTableViewRowAnimation)rowAnimation {
    return [objc_getAssociatedObject(self, @selector(rowAnimation)) integerValue];
}

- (void)setRowAnimation:(VMTableViewRowAnimation)rowAnimation {
    objc_setAssociatedObject(self, @selector(rowAnimation), @(rowAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Layout

- (void)reloadIfNeed {
#if TARGET_OS_IPHONE
    NSArray<__kindof NSIndexPath *> *indexPathsForVisibleRows = self.indexPathsForVisibleRows;
    if ([self.dataSource respondsToSelector:@selector(tableView:cellViewModelForIndexPath:)]) {
        for (NSIndexPath *indexPath in indexPathsForVisibleRows) {
            CellViewModel *cellViewModel = [(id<ITableViewModelDataSource>)self.dataSource tableView:self cellViewModelForIndexPath:indexPath];
            [(TableViewModelCell *)[self cellForRowAtIndexPath:indexPath] setViewModel:cellViewModel];
        }
    }
#elif TARGET_OS_MAC
#endif // #if TARGET_OS_IPHONE
}

@end
