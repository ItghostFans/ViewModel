//
//  TableViewModel+TableViewDelegate.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import "TableViewModel+TableViewDelegate.h"

#import <ViewModel/SectionViewModel+TableView.h>
#import <ViewModel/CellViewModel+TableView.h>
#import <ViewModel/TableViewModelCell.h>
#import <ViewModel/TableHeaderView.h>
#import <ViewModel/TableFooterView.h>

@implementation TableViewModel (TableViewDelegate)

#if TARGET_OS_IPHONE

- (CGFloat)tableView:(VMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionViewModels[indexPath.section][indexPath.row] tableCellHeightForWidth:CGRectGetWidth(tableView.frame)];
}

- (void)tableView:(VMTableView *)tableView willDisplayCell:(VMTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.row];
    ((TableViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)tableView:(VMTableView *)tableView didEndDisplayingCell:(VMTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((TableViewModelCell *)cell).viewModel = nil;
}

- (void)tableView:(VMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    if (cellViewModel.deselectAfterDidSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

/// mark - Header

- (VMView *)tableView:(VMTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableHeaderClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableHeaderClass)];
    }
    return nil;
}

- (CGFloat)tableView:(VMTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableHeaderHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(VMTableView *)tableView willDisplayHeaderView:(VMView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableHeaderView *)view).viewModel = sectionViewModel;
}

- (void)tableView:(VMTableView *)tableView didEndDisplayingHeaderView:(VMView *)view forSection:(NSInteger)section {
    ((TableHeaderView *)view).viewModel = nil;
}

/// mark - Footer

- (VMView *)tableView:(VMTableView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableFooterClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableFooterClass)];
    }
    return nil;
}

- (CGFloat)tableView:(VMTableView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableFooterHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(VMTableView *)tableView willDisplayFooterView:(VMView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableFooterView *)view).viewModel = sectionViewModel;
}

- (void)tableView:(VMTableView *)tableView didEndDisplayingFooterView:(VMView *)view forSection:(NSInteger)section {
    ((TableFooterView *)view).viewModel = nil;
}

#elif TARGET_OS_MAC

- (nullable VMView *)tableView:(VMTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    NSUInteger column = [tableView.tableColumns indexOfObject:tableColumn];
    if (column == NSNotFound) {
        return nil;
    }
    return [tableView viewAtColumn:column row:row makeIfNecessary:NO];
}

- (nullable NSTableRowView *)tableView:(VMTableView *)tableView rowViewForRow:(NSInteger)row {
    return [tableView rowViewAtRow:row makeIfNecessary:NO];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return [self.sectionViewModels[0][row] tableCellHeightForWidth:CGRectGetWidth(tableView.frame)];
}

#endif // #if TARGET_OS_IPHONE

@end
