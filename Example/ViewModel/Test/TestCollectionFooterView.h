//
//  TestCollectionFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CollectionFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestCollectionFooterView : CollectionFooterView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
