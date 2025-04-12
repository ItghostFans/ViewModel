//
//  AutoTableHeaderView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "TableHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoSectionViewModel;

@interface AutoTableHeaderView : TableHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) AutoSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(AutoSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
