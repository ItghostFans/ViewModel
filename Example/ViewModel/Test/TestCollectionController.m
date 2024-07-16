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
@property (weak, nonatomic) UIButton *addRowButton;
@end

@implementation TestCollectionController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    ColumnRowFlowLayout *collectionViewFlowLayout = ColumnRowFlowLayout.new;
    collectionViewFlowLayout.columnCount = 3;
    collectionViewFlowLayout.rowCount = 10;
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    collectionViewFlowLayout.viewModel = self.viewModel.collectionViewModel;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(3, 4, 0, 6);
    self.collectionView.pagingEnabled = YES;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addSectionButton.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
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
            [sectionViewModel addViewModel:TestCellViewModel.new];
            [self.viewModel.collectionViewModel.sectionViewModels addViewModel:sectionViewModel];
        } completion:^(BOOL finished) {
        }];
        return [RACSignal return:nil];
    }];
    self.addRowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel.collectionViewModel.collectionView performBatchUpdates:^{
            @strongify(self);
            SectionViewModel *sectionViewModel = self.viewModel.collectionViewModel.sectionViewModels.viewModels.firstObject;
            if (sectionViewModel) {
                [sectionViewModel addViewModel:TestCellViewModel.new];
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

- (UIButton *)addRowButton {
    if (!_addRowButton) {
        UIButton *addRowButton = UIButton.new;
        [self.view addSubview:addRowButton];
        _addRowButton = addRowButton;
        [_addRowButton setTitle:@"Add Item" forState:(UIControlStateNormal)];
        [_addRowButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_addRowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.equalTo(self.addSectionButton.mas_trailing);
        }];
    }
    return _addRowButton;
}

@end
