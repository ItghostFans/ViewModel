//
//  TableController.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableController.h"

#import <ViewModel/TableViewModel.h>
#import <ViewModel/TableControllerViewModel.h>

@interface TableController ()

@property (weak, nonatomic) VMTableView *tableView;

@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setViewModel:(TableControllerViewModel *)viewModel {
    _viewModel = viewModel;
}

#pragma mark - Getter

- (VMTableView *)tableView {
    if (_tableView) {
        return _tableView;
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
    VMTableView *tableView = [[VMTableView alloc] initWithFrame:CGRectZero style:VMTableViewStyleGrouped];
    tableView.separatorStyle = VMTableViewCellSeparatorStyleNone;
#pragma clang diagnostic pop
    _tableView = tableView;
    // 为了兼容部分iOS系统会有35像素的tableHeaderView的height占位。
#if TARGET_OS_IPHONE
    _tableView.tableHeaderView = [[VMTableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([VMScreen mainScreen].bounds), 0.0001f)];
    // 为了兼容部分iOS系统会有20像素的tableFooterView的height占位。
    _tableView.tableFooterView = [[VMView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([VMScreen mainScreen].bounds), 0.0001f)];
    _tableView.backgroundColor = [VMColor clearColor];
    _tableView.allowsSelection = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
#elif TARGET_OS_MAC
    _tableView.tableHeaderView = nil;
#endif // #if TARGET_OS_IPHONE
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_14_5
    if (@available(iOS 15.0, *)) {
        _tableView.sectionHeaderTopPadding = 0;
    }
#endif
    return tableView;
}

#pragma mark - Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.viewModel.tableViewModel respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [self.viewModel.tableViewModel.class instanceMethodSignatureForSelector:aSelector];
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.viewModel.tableViewModel];
}

@end
