//
//  ViewController.m
//  MVVM
//
//  Created by ItghostFans on 05/29/2024.
//  Copyright (c) 2024 ItghostFans. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

#import "TestSectionViewModel.h"
#import "TestCellViewModel.h"
#import "TestTableControllerViewModel.h"
#import "TestCollectionControllerViewModel.h"
#import "TestTableController.h"
#import "TestCollectionController.h"
#import "TableViewModel.h"
#import "CollectionViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) UIButton *openTableButton;
@property (weak, nonatomic) UIButton *openCollectionButton;

@property (strong, nonatomic) TestSectionViewModel *sectionViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionViewModel = [TestSectionViewModel new];
    [_sectionViewModel addViewModel:TestCellViewModel.new];
    [_sectionViewModel addViewModel:TestCellViewModel.new];
	// Do any additional setup after loading the view, typically from a nib.
    @weakify(self);
    self.openTableButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        TableViewModel *viewModel = TableViewModel.new;
        [viewModel.sectionViewModels addViewModel:self.sectionViewModel];
        TestTableControllerViewModel *controllerViewModel = [[TestTableControllerViewModel alloc] initWithTableViewModel:viewModel];
        TestTableController *controller = [TestTableController new];
        controller.viewModel = controllerViewModel;
        [self.navigationController pushViewController:controller animated:YES];
        return [RACSignal return:nil];
    }];
    self.openCollectionButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        CollectionViewModel *viewModel = CollectionViewModel.new;
        [viewModel.sectionViewModels addViewModel:self.sectionViewModel];
        TestCollectionControllerViewModel *controllerViewModel = [[TestCollectionControllerViewModel alloc] initWithCollectionViewModel:viewModel];
        TestCollectionController *controller = [TestCollectionController new];
        controller.viewModel = controllerViewModel;
        [self.navigationController pushViewController:controller animated:YES];
        return [RACSignal return:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)openTableButton {
    if (!_openTableButton) {
        UIButton *openTableButton = UIButton.new;
        [self.view addSubview:openTableButton];
        _openTableButton = openTableButton;
        [_openTableButton setTitle:@"Open Table" forState:(UIControlStateNormal)];
        [_openTableButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_openTableButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_centerY).offset(-10.0f);
            make.centerX.equalTo(self.view);
        }];
    }
    return _openTableButton;
}

- (UIButton *)openCollectionButton {
    if (!_openCollectionButton) {
        UIButton *openCollectionButton = UIButton.new;
        [self.view addSubview:openCollectionButton];
        _openCollectionButton = openCollectionButton;
        [_openCollectionButton setTitle:@"Open Collection" forState:(UIControlStateNormal)];
        [_openCollectionButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_openCollectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_centerY).offset(10.0f);
            make.centerX.equalTo(self.view);
        }];
    }
    return _openCollectionButton;
}

@end
