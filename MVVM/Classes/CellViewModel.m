//
//  CellViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

@implementation CellViewModel

- (instancetype)init {
    if (self = [super init]) {
        _deselectAfterDidSelect = YES;
    }
    return self;
}

- (void)setDelegate:(id<ICellViewModelDelegate>)delegate {
    [super setDelegate:delegate];
}

- (id<ICellViewModelDelegate>)delegate {
    return (id<ICellViewModelDelegate>)[super delegate];
}

@end
