//
//  ExampleTableHeaderView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import <ViewModel/TableHeaderView.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionViewModel;

@interface ExampleTableHeaderView : TableHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ExampleSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(ExampleSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
