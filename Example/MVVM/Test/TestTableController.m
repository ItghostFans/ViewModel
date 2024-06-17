//
//  TestTableController.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestTableController.h"
#import "TestTableControllerViewModel.h"

#import "TableViewModel.h"

#import <Masonry/Masonry.h>

@interface TestTableController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestTableController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.viewModel.tableViewModel.tableView = self.tableView;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
