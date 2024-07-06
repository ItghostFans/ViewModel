//
//  CellViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

@implementation CellViewModel

@synthesize delegate = _delegate;

- (instancetype)init {
    if (self = [super init]) {
        _deselectAfterDidSelect = YES;
    }
    return self;
}

@end
