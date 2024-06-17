//
//  TestTableHeaderView.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestTableHeaderView.h"
#import "TestSectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestTableHeaderView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation TestTableHeaderView

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

#pragma mark - TableHeaderView

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestSectionViewModel *)viewModel {
    return 0.0f;
}

@end
