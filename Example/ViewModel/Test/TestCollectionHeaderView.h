//
//  TestCollectionHeaderView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CollectionHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestCollectionHeaderView : CollectionHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)headerSizeForSize:(CGSize *)size viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
