//
//  ExampleCollectionHeaderView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import <ViewModel/CollectionHeaderView.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionViewModel;

@interface ExampleCollectionHeaderView : CollectionHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ExampleSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)headerSizeForSize:(CGSize)size viewModel:(ExampleSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
