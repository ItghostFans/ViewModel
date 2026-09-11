//
//  TableControllerViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "TableControllerViewModel.h"

#import <ViewModel/VMTableView+ViewModel.h>
#import <ViewModel/TableViewModel+Private.h>

@implementation TableControllerViewModel

- (instancetype)initWithTableViewModel:(TableViewModel *)tableViewModel {
    if (self = [self init]) {
        if (!tableViewModel) {
            _tableViewModel = TableViewModel.new;
            [_tableViewModel.sectionViewModels addViewModel:SectionViewModel.new];
        } else {
            _tableViewModel = tableViewModel;
        }
    }
    return self;
}

#pragma mark - Update TableView

- (void)tableViewUpdates:(void(^)(void))updates
            rowAnimation:(VMTableViewRowAnimation)rowAnimation
              completion:(void (^)(BOOL finished))completion {
//    if (self.tableViewModel.tableView) {
//        [self.tableViewModel.tableView performBatchUpdates:updates rowAnimation:(rowAnimation) completion:completion];
//    } else {
    self.tableViewModel.rowAnimation = rowAnimation;
    self.tableViewModel.batchCompletion = completion;
    if (updates) {updates();}
//    if (completion) {completion(YES);}
//    }
}

@end
