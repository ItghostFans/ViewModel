//
//  TestTableHeaderView.h
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestTableHeaderView : TableHeaderView

@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END