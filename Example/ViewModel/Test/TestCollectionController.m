//
//  TestCollectionController.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionController.h"
#import "TestCollectionControllerViewModel.h"

#import "CollectionViewModel.h"

#import <Masonry/Masonry.h>

#import "ColumnRowFlowLayout.h"
#import "TestCellViewModel.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "CollectionViewModel.h"
#import "TestCellViewModel.h"
#import "TestSectionViewModel.h"

@interface TestCollectionController ()
@property (weak, nonatomic) UIButton *addSectionButton;
@property (weak, nonatomic) UIButton *addItemButton;
@property (weak, nonatomic) UIButton *deleteRowButton;
@end

@implementation TestCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    ColumnRowFlowLayout *collectionViewFlowLayout = ColumnRowFlowLayout.new;
    collectionViewFlowLayout.columnCount = 3;
    collectionViewFlowLayout.rowCount = 10;
//    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.contentInset = UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 5.0f);
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.pagingEnabled = YES;        // pagingEnabled为YES时，不要设置contentInset，否则会有不可预期的抖动。
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addSectionButton.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
//    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
//    collectionViewFlowLayout.viewModel = self.viewModel.collectionViewModel;
    if ([self.collectionView.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    self.viewModel.collectionViewModel.collectionView = self.collectionView;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.viewModel.collectionViewModel.sectionViewModels[0] addViewModel:TestCellViewModel.new];
//    });
    
    @weakify(self);
    self.addSectionButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel.collectionViewModel.collectionView performBatchUpdates:^{
            @strongify(self);
            TestSectionViewModel *sectionViewModel = TestSectionViewModel.new;
            sectionViewModel.collectionMinimumLineSpacing = 5.0f;
            sectionViewModel.collectionMinimumInteritemSpacing = 10.0f;
            [sectionViewModel addViewModel:TestCellViewModel.new];
            [self.viewModel.collectionViewModel.sectionViewModels addViewModel:sectionViewModel];
        } completion:^(BOOL finished) {
        }];
        return [RACSignal return:nil];
    }];
    self.addItemButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [UIView setAnimationsEnabled:NO];
        [self.viewModel.collectionViewModel.collectionView performBatchUpdates:^{
            @strongify(self);
            SectionViewModel *sectionViewModel = self.viewModel.collectionViewModel.sectionViewModels.viewModels.firstObject;
            if (sectionViewModel) {
                [sectionViewModel insertViewModel:TestCellViewModel.new atIndex:0];
                [sectionViewModel insertViewModel:TestCellViewModel.new atIndex:0];
//                [sectionViewModel addViewModel:TestCellViewModel.new];
//                [sectionViewModel addViewModel:TestCellViewModel.new];
            }
        } completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
        return [RACSignal return:nil];
    }];
    self.deleteRowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel.collectionViewModel.collectionView performBatchUpdates:^{
            @strongify(self);
            SectionViewModel *sectionViewModel = self.viewModel.collectionViewModel.sectionViewModels.viewModels.firstObject;
            if (sectionViewModel.viewModels.count) {
                [sectionViewModel removeViewModelsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
            }
        } completion:^(BOOL finished) {
        }];
        return [RACSignal return:nil];
    }];
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

- (UIButton *)addSectionButton {
    if (!_addSectionButton) {
        UIButton *addSectionButton = UIButton.new;
        addSectionButton.backgroundColor = UIColor.grayColor;
        [self.view addSubview:addSectionButton];
        _addSectionButton = addSectionButton;
        [_addSectionButton setTitle:@"Add Section" forState:(UIControlStateNormal)];
        [_addSectionButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_addSectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.equalTo(self.view);
        }];
    }
    return _addSectionButton;
}

- (UIButton *)addItemButton {
    if (!_addItemButton) {
        UIButton *addItemButton = UIButton.new;
        addItemButton.backgroundColor = UIColor.grayColor;
        [self.view addSubview:addItemButton];
        _addItemButton = addItemButton;
        [_addItemButton setTitle:@"Add Item" forState:(UIControlStateNormal)];
        [_addItemButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_addItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.equalTo(self.addSectionButton.mas_trailing).offset(2.0f);
        }];
    }
    return _addItemButton;
}

- (UIButton *)deleteRowButton {
    if (!_deleteRowButton) {
        UIButton *deleteRowButton = UIButton.new;
        deleteRowButton.backgroundColor = UIColor.grayColor;
        [self.view addSubview:deleteRowButton];
        _deleteRowButton = deleteRowButton;
        [_deleteRowButton setTitle:@"Delete Item" forState:(UIControlStateNormal)];
        [_deleteRowButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_deleteRowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.equalTo(self.addItemButton.mas_trailing).offset(2.0f);
        }];
    }
    return _deleteRowButton;
}

@end
