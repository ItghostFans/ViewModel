//
//  TestTableHeaderView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestTableHeaderView : TableHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
