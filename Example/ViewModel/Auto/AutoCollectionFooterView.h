//
//  AutoCollectionFooterView.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CollectionFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoSectionViewModel;

@interface AutoCollectionFooterView : CollectionFooterView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) AutoSectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(AutoSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
