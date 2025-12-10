//
//  TableController.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableControllerViewModel;

@interface TableController : VMViewController

@property (weak, nonatomic, readonly) VMTableView *tableView;
@property (strong, nonatomic, nullable) TableControllerViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
