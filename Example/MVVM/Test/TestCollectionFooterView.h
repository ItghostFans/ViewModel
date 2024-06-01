//
//  TestCollectionFooterView.h
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/1.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CollectionFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@interface TestCollectionFooterView : CollectionFooterView

@property (weak, nonatomic, nullable) TestSectionViewModel *viewModel;

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(TestSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END