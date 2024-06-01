//
//  CellViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@protocol ICellViewModelDelegate <IBaseViewModelDelegate>
@end

@interface CellViewModel : BaseViewModel

@property (weak, nonatomic, nullable) id<ICellViewModelDelegate> delegate;

@property (assign, nonatomic) BOOL deselectAfterDidSelect;       // Default is YES.

@end

NS_ASSUME_NONNULL_END
