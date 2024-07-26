//
//  TestSectionViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "SectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TestSectionViewModel;

@protocol ITestSectionViewModelDelegate <IBaseViewModelDelegate>
@end

@interface TestSectionViewModel : SectionViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITestSectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
