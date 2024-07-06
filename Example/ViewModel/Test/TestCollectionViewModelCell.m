//
//  TestCollectionViewModelCell.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
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
        self.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                               alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(TestCollectionCellViewModel *)viewModel {
    [super setViewModel:viewModel];
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
