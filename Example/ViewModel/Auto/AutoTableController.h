//
//  AutoTableController.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableController.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoTableControllerViewModel;

@interface AutoTableController : TableController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic, nullable) AutoTableControllerViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
