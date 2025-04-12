//
//  AutoTableController.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "AutoTableController.h"
#import "AutoTableControllerViewModel.h"
#import "TableViewModel.h"

@interface AutoTableController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation AutoTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
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
