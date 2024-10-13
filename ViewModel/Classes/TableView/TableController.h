//
//  TableController.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableControllerViewModel;

@interface TableController : UIViewController

@property (weak, nonatomic, readonly) UITableView *tableView;
@property (strong, nonatomic, nullable) TableControllerViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
