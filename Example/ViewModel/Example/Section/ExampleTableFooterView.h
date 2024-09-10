//
//  ExampleTableFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import <ViewModel/TableFooterView.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionViewModel;

@interface ExampleTableFooterView : TableFooterView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ExampleSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(ExampleSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
