//
//  TableViewModel+UITableViewDelegate.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import "TableViewModel+UITableViewDelegate.h"

#import "SectionViewModel+TableView.h"
#import "CellViewModel+TableView.h"

#import "TableViewModelCell.h"
#import "TableHeaderView.h"
#import "TableFooterView.h"

@implementation TableViewModel (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionViewModels[indexPath.section][indexPath.row] tableCellHeightForWidth:CGRectGetWidth(tableView.frame)];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.row];
    ((TableViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((TableViewModelCell *)cell).viewModel = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    if (cellViewModel.deselectAfterDidSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

/// mark - Header

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableHeaderClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableHeaderClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableHeaderHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableHeaderView *)view).viewModel = sectionViewModel;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    ((TableHeaderView *)view).viewModel = nil;
}

/// mark - Footer

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableFooterClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableFooterClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableFooterHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableFooterView *)view).viewModel = sectionViewModel;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    ((TableFooterView *)view).viewModel = nil;
}

@end
