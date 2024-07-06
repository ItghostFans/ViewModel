//
//  TableViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

#import "BaseViewModel.h"

#import "SectionViewModel+TableView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ITableViewModelDelegate <IBaseViewModelDelegate>
@end

@class CellViewModel;

@interface TableViewModel : BaseViewModel

@property (weak, nonatomic, nullable) id<ITableViewModelDelegate> delegate;

@property (strong, nonatomic) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
