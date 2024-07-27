//
//  TableViewModel+UITableViewModelDataSource.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/27.
//

#import "TableViewModel+UITableViewModelDataSource.h"
#import "CellViewModel+TableView.h"

@implementation TableViewModel (UITableViewModelDataSource)

- (CellViewModel *)tableView:(UITableView *)tableView cellViewModelForIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.row];
    return cellViewModel;
}

- (SectionViewModel *)tableView:(UITableView *)tableView sectionViewModelForSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel;
}

@end
