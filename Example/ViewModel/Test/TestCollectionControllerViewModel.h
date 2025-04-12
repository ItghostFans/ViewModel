//
//  TestCollectionControllerViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CollectionControllerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TestCollectionControllerViewModel;

@protocol ITestCollectionControllerViewModelDelegate <IBaseViewModelDelegate>
@end

@interface TestCollectionControllerViewModel : CollectionControllerViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITestCollectionControllerViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
