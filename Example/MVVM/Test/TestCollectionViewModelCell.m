//
//  TestCollectionViewModelCell.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionViewModelCell.h"
#import "TestCollectionCellViewModel.h"

#import <Masonry/Masonry.h>

@interface TestCollectionViewModelCell ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestCollectionViewModelCell

@synthesize viewModel = _viewModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - CollectionViewModelCell

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(TestCollectionCellViewModel *)viewModel {
    return CGSizeMake(30.0f, 30.0f);
}

@end
