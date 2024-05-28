//
//  TableViewController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableViewController.h"

#import "TableViewModel.h"

@interface TableViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setViewModel:(TableViewModel *)viewModel {
    _viewModel = viewModel;
    _viewModel.tableView = self.tableView;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_14_5
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
#endif
    }
    return _tableView;
}

@end
