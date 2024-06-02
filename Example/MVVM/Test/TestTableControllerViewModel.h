//
//  TestTableControllerViewModel.h
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableControllerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TestTableControllerViewModel;

@protocol ITestTableControllerViewModelDelegate <IBaseViewModelDelegate>
@end

@interface TestTableControllerViewModel : TableControllerViewModel

@property (weak, nonatomic, nullable) id<ITestTableControllerViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
