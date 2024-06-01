//
//  TableControllerViewModel.m
//  MVVM
//
//  Created by ItghostFan on 2024/6/1.
//

#import "TableControllerViewModel.h"

@implementation TableControllerViewModel

- (instancetype)initWithTableViewModel:(TableViewModel *)tableViewModel {
    if (self = [super init]) {
        _tableViewModel = tableViewModel;
    }
    return self;
}

@end
