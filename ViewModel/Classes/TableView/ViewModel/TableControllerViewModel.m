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
        if (!tableViewModel) {
            _tableViewModel = TableViewModel.new;
        } else {
            _tableViewModel = tableViewModel;
        }
        [_tableViewModel.sectionViewModels addViewModel:SectionViewModel.new];
    }
    return self;
}

#pragma mark - Update TableView

- (void)tableViewUpdate:(void(^)(void))update
           rowAnimation:(VMTableViewRowAnimation)rowAnimation
             completion:(void (^)(BOOL finished))completion {
    if (self.tableViewModel.tableView) {
        [self.tableViewModel.tableView performBatchUpdates:update rowAnimation:(VMTableViewRowAnimationNone) completion:completion];
    } else {
        if (update) {update();}
        if (completion) {completion(YES);}
    }
}

@end
