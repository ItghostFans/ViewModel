//
//  ExampleSectionViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import <ViewModel/SectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionViewModel;

@protocol IExampleSectionViewModelDelegate <IBaseViewModelDelegate>
@end

@interface ExampleSectionViewModel : SectionViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<IExampleSectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
