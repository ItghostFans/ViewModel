//
//  TableViewModel+UITableViewDataSource.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import "TableViewModel+UITableViewDataSource.h"

#import <ViewModel/CellViewModel+TableView.h>

@implementation TableViewModel (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellViewModel.tableCellClass) forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionViewModels[section] count];
}

@end
