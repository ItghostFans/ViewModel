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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (strong, nonatomic, nullable) TestTableControllerViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
