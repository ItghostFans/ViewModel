//
//  TableViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

#import <ViewModel/BaseViewModel.h>
#import <ViewModel/SectionViewModel+TableView.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;
@class TableViewModel;

@protocol ITableViewModelDelegate <IBaseViewModelDelegate>
@end

@protocol ITableViewModelDataSource <
#if TARGET_OS_IPHONE
UITableViewDataSource
#elif TARGET_OS_MAC
NSTableViewDataSource
#endif // #if TARGET_OS_IPHONE
>
@optional

- (CellViewModel *)tableView:(VMTableView * _Nonnull)tableView
   cellViewModelForIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (SectionViewModel *)tableView:(VMTableView *_Nonnull)tableView
     sectionViewModelForSection:(NSInteger)section;
@end

@interface TableViewModel : BaseViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ITableViewModelDelegate> delegate;
#pragma clang diagnostic pop

@property (strong, nonatomic, nonnull) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) VMTableView *tableView;

@end

NS_ASSUME_NONNULL_END
