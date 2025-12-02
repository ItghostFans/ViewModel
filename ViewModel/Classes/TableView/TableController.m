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

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setViewModel:(TableControllerViewModel *)viewModel {
    _viewModel = viewModel;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    // 为了兼容部分iOS系统会有35像素的tableHeaderView的height占位。
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(UIScreen.mainScreen.bounds), 0.0001f)];
    // 为了兼容部分iOS系统会有20像素的tableFooterView的height占位。
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(UIScreen.mainScreen.bounds), 0.0001f)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
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
