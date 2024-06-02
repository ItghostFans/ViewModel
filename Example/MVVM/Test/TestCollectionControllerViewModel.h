//
//  TestCollectionControllerViewModel.h
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CollectionControllerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TestCollectionControllerViewModel;

@protocol ITestCollectionControllerViewModelDelegate <IBaseViewModelDelegate>
@end

@interface TestCollectionControllerViewModel : CollectionControllerViewModel

@property (weak, nonatomic, nullable) id<ITestCollectionControllerViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
