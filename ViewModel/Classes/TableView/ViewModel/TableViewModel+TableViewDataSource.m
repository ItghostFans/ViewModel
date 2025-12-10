//
//  TableViewModel+TableViewDataSource.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import "TableViewModel+TableViewDataSource.h"

#import <ViewModel/CellViewModel+TableView.h>

@implementation TableViewModel (TableViewDataSource)

#if TARGET_OS_IPHONE
- (NSInteger)numberOfSectionsInTableView:(VMTableView *)tableView {
    return self.sectionViewModels.count;
}

- (VMTableViewCell *)tableView:(VMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellViewModel.tableCellClass) forIndexPath:indexPath];
}

- (NSInteger)tableView:(VMTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionViewModels[section] count];
}

#elif TARGET_OS_MAC

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    SectionViewModel *sectionViewModel = self.sectionViewModels.firstViewModel;
    return sectionViewModel.count;
}

#endif // #if TARGET_OS_IPHONE

@end
