//
//  AutoTableFooterView.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "AutoTableFooterView.h"
#import "AutoSectionViewModel.h"

#import <Masonry/Masonry.h>

@interface AutoTableFooterView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation AutoTableFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                                           green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                            blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                                           alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(AutoSectionViewModel *)viewModel {
    BOOL same = self.viewModel == viewModel;
    [super setViewModel:viewModel];
    if (same) {
        // 防止这里不必要的UI刷新。
        return;
    }
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - TableFooterView

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(AutoSectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return 0.0f;
}

@end
