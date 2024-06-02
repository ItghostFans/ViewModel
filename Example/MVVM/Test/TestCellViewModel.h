//
//  TestCellViewModel.h
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "CellViewModel+TableView.h"
#import "CellViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestCellViewModel;

@protocol ITestCellViewModelDelegate <ICellViewModelDelegate>
@end

@interface TestCellViewModel : CellViewModel

@property (weak, nonatomic, nullable) id<ITestCellViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
