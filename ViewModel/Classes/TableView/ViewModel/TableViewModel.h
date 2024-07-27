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

@class CellViewModel;
@class TableViewModel;

@protocol ITableViewModelDelegate <IBaseViewModelDelegate>
@end

@protocol UITableViewModelDataSource <UITableViewDataSource>
@optional
- (CellViewModel *)tableView:(UITableView *)tableView cellViewModelForIndexPath:(NSIndexPath *)indexPath;
- (SectionViewModel *)tableView:(UITableView *)tableView sectionViewModelForSection:(NSInteger)section;
@end

@interface TableViewModel : BaseViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITableViewModelDelegate> delegate;
#pragma clang diagnostic pop

@property (strong, nonatomic) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
