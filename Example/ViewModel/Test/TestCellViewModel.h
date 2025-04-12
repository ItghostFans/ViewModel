//
//  TestCellViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CellViewModel+TableView.h"
#import "CellViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class TestCellViewModel;

@protocol ITestCellViewModelDelegate <ICellViewModelDelegate>
@end

@interface TestCellViewModel : CellViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITestCellViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
