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

#import "CollectionFlowLayout.h"
#import "TestCellViewModel.h"

@interface TestCollectionController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestCollectionController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
//    self.collectionView.collectionViewLayout = CollectionFlowLayout.new;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.viewModel.collectionViewModel.collectionView = self.collectionView;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.viewModel.collectionViewModel.sectionViewModels[0] addViewModel:TestCellViewModel.new];
//    });
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
