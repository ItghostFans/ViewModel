//
//  TableControllerViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "TableControllerViewModel.h"

#import <ViewModel/VMTableView+ViewModel.h>
#import <ViewModel/TableViewModel.h>

@implementation TableControllerViewModel

- (instancetype)initWithTableViewModel:(TableViewModel *)tableViewModel {
    if (self = [self init]) {
        _tableViewModel = tableViewModel;
    }
    return self;
}

#pragma mark - Update TableView

- (void)tableViewUpdate:(void(^)(void))update completion:(void (^)(BOOL finished))completion {
    if (self.tableViewModel.tableView) {
        [self.tableViewModel.tableView performBatchUpdates:update rowAnimation:(VMTableViewRowAnimationNone) completion:completion];
    } else {
        if (update) {update();}
        if (completion) {completion(YES);}
    }
}

@end
