//
//  TestTableController.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TableController.h"

NS_ASSUME_NONNULL_BEGIN

@class TestTableControllerViewModel;

@interface TestTableController : TableController

@property (strong, nonatomic, nullable) TestTableControllerViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
