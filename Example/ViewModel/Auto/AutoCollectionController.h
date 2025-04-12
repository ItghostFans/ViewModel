//
//  AutoCollectionController.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CollectionController.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoCollectionControllerViewModel;

@interface AutoCollectionController : CollectionController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic, nullable) AutoCollectionControllerViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
