//
//  TableViewModel+ITableViewModelDataSource.m
//  ViewModel
//
//  Created by ItghostFan on 2024/7/27.
//

#import "TableViewModel+ITableViewModelDataSource.h"

#import <ViewModel/CellViewModel+TableView.h>

@implementation TableViewModel (ITableViewModelDataSource)

- (CellViewModel *)tableView:(VMTableView *)tableView cellViewModelForIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.row];
    return cellViewModel;
}

- (SectionViewModel *)tableView:(VMTableView *)tableView sectionViewModelForSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel;
}

@end
