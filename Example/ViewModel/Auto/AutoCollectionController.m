//
//  AutoCollectionController.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "AutoCollectionController.h"
#import "AutoCollectionControllerViewModel.h"
#import "CollectionViewModel.h"

@interface AutoCollectionController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation AutoCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    self.viewModel.collectionViewModel.collectionView = self.collectionView;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
