//
//  TestAnotherCellViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/11/22.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import <ViewModel/CellViewModel+TableView.h>
#import <ViewModel/CellViewModel+CollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@class TestAnotherCellViewModel;

@protocol ITestAnotherCellViewModelDelegate <ICellViewModelDelegate>
@end

@interface TestAnotherCellViewModel : CellViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITestAnotherCellViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
