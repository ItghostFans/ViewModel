//___FILEHEADER___

#import "___VARIABLE_productName___TableController.h"
#import "___VARIABLE_productName___TableControllerViewModel.h"
#import "TableViewModel.h"

@interface ___VARIABLE_productName___TableController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___TableController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.viewModel.tableViewModel.tableView = self.tableView;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
