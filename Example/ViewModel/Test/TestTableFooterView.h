//
//  TestTableFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestTableFooterView : TableFooterView

@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
