//
//  AutoSectionViewModel.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "SectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class AutoSectionViewModel;

@protocol IAutoSectionViewModelDelegate <IBaseViewModelDelegate>
@end

@interface AutoSectionViewModel : SectionViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<IAutoSectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
