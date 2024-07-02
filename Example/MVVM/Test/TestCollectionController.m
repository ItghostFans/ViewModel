//
//  TestCollectionController.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionController.h"
#import "TestCollectionControllerViewModel.h"

#import "CollectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestCollectionController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestCollectionController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.viewModel.collectionViewModel.collectionView = self.collectionView;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
