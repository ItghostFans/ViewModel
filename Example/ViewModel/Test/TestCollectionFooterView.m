//
//  TestCollectionFooterView.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionFooterView.h"
#import "TestSectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestCollectionFooterView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                               alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(TestSectionViewModel *)viewModel {
    [super setViewModel:viewModel];
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - CollectionFooterView

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(TestSectionViewModel *)viewModel {
    return CGSizeMake(1.0f, size->width);
}

@end
