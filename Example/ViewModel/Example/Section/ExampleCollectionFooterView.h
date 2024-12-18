//
//  ExampleCollectionFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import <ViewModel/CollectionFooterView.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionViewModel;

@interface ExampleCollectionFooterView : CollectionFooterView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ExampleSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(ExampleSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
