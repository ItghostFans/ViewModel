//
//  TestCollectionFooterView.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/1.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionFooterView.h"
#import "TestSectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestCollectionFooterView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestCollectionFooterView

@synthesize viewModel = _viewModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - CollectionFooterView

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(TestSectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
