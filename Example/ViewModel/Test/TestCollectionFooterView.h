//
//  TestCollectionFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CollectionFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestCollectionFooterView : CollectionFooterView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
