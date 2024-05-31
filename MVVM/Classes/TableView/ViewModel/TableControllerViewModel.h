//
//  TableControllerViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/6/1.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TableViewModel;

@interface TableControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) TableViewModel *tableViewModel;

@end

NS_ASSUME_NONNULL_END
