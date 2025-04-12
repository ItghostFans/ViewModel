//
//  AutoCollectionControllerViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CollectionControllerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoCollectionControllerViewModel;

@protocol IAutoCollectionControllerViewModelDelegate <IBaseViewModelDelegate>
@end

@interface AutoCollectionControllerViewModel : CollectionControllerViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<IAutoCollectionControllerViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
