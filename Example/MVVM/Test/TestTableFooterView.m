//
//  TestTableFooterView.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestTableFooterView.h"
#import "TestSectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestTableFooterView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestTableFooterView

@synthesize viewModel = _viewModel;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - TableFooterView

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestSectionViewModel *)viewModel {
    return 1.0f;
}

@end
