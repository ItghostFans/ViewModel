//
//  CellViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <ViewModel/BaseViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@protocol ICellViewModelDelegate <IBaseViewModelDelegate>
@end

@interface CellViewModel : BaseViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ICellViewModelDelegate> delegate;
#pragma clang diagnostic pop

@property (assign, nonatomic) BOOL deselectAfterDidSelect;       // Default is YES.

@end

NS_ASSUME_NONNULL_END
