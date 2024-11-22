//
//  TestTableController.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestTableController.h"
#import "TestTableControllerViewModel.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import <ViewModel/UITableView+ViewModel.h>

#import "TableViewModel.h"
#import "TestCellViewModel.h"
#import "TestSectionViewModel.h"
#import "TestAnotherCellViewModel.h"

@interface TestTableController () <UITableViewDelegate>
@property (weak, nonatomic) UIButton *addSectionButton;
@property (weak, nonatomic) UIButton *addRowButton;
@property (weak, nonatomic) UIButton *deleteRowButton;
@end

@implementation TestTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addSectionButton.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.viewModel.tableViewModel.tableView = self.tableView;
    
    @weakify(self);
    self.addSectionButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel.tableViewModel.tableView performBatchUpdates:^{
            @strongify(self);
            TestSectionViewModel *sectionViewModel = TestSectionViewModel.new;
            [sectionViewModel addViewModel:TestCellViewModel.new];
            [self.viewModel.tableViewModel.sectionViewModels addViewModel:sectionViewModel];
        } rowAnimation:(UITableViewRowAnimationRight)  completion:^(BOOL finished) {
        }];
        return [RACSignal return:nil];
    }];
    self.addRowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [UIView setAnimationsEnabled:NO];
        [self.viewModel.tableViewModel.tableView performBatchUpdates:^{
            @strongify(self);
            SectionViewModel *sectionViewModel = self.viewModel.tableViewModel.sectionViewModels.firstViewModel;
            if (sectionViewModel) {
                TestCellViewModel *cellViewModel = sectionViewModel.firstViewModel;
                [sectionViewModel removeViewModel:cellViewModel];
                if ([cellViewModel isKindOfClass:TestCellViewModel.class]) {
                    [sectionViewModel insertViewModel:TestAnotherCellViewModel.new atIndex:sectionViewModel.count];
                } else {
                    [sectionViewModel insertViewModel:TestCellViewModel.new atIndex:sectionViewModel.count];
                }
            }
        } rowAnimation:(UITableViewRowAnimationNone) completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
        return [RACSignal return:nil];
    }];
    self.deleteRowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel.tableViewModel.tableView performBatchUpdates:^{
            @strongify(self);
            SectionViewModel *sectionViewModel = self.viewModel.tableViewModel.sectionViewModels.firstViewModel;
            if (sectionViewModel.count) {
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

- (UIButton *)addRowButton {
    if (!_addRowButton) {
        UIButton *addRowButton = UIButton.new;
        addRowButton.backgroundColor = UIColor.grayColor;
        [self.view addSubview:addRowButton];
        _addRowButton = addRowButton;
        [_addRowButton setTitle:@"Add Row" forState:(UIControlStateNormal)];
        [_addRowButton setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_addRowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.equalTo(self.addSectionButton.mas_trailing).offset(2.0f);
        }];
    }
    return _addRowButton;
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
            make.leading.equalTo(self.addRowButton.mas_trailing).offset(2.0f);
        }];
    }
    return _deleteRowButton;
}

#pragma mark - Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.viewModel.tableViewModel respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [self.viewModel.tableViewModel.class instanceMethodSignatureForSelector:aSelector];
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.viewModel.tableViewModel];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.viewModel.tableViewModel.sectionViewModels[indexPath.section];
    if (sectionViewModel) {
        TestCellViewModel *cellViewModel = sectionViewModel[indexPath.row];
        [sectionViewModel removeViewModel:cellViewModel];
        if ([cellViewModel isKindOfClass:TestCellViewModel.class]) {
            [sectionViewModel insertViewModel:TestAnotherCellViewModel.new atIndex:sectionViewModel.count];
        } else {
            [sectionViewModel insertViewModel:TestCellViewModel.new atIndex:sectionViewModel.count];
        }
    }
}

@end
