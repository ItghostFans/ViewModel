//
//  TableControllerViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TableViewModel;

@interface TableControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) TableViewModel *tableViewModel;

- (instancetype)initWithTableViewModel:(TableViewModel *)tableViewModel;

#pragma mark - Update TableView

- (void)tableViewUpdate:(void(^)(void))update completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
