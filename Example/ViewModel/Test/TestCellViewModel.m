//
//  TestCellViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "TestCellViewModel.h"
#import "TestTableCellViewModel.h"
#import "TestTableViewModelCell.h"
#import "TestCollectionCellViewModel.h"
#import "TestCollectionViewModelCell.h"

@interface TestCellViewModel ()
@property (strong, nonatomic) TestTableCellViewModel *tableCellViewModel;
@property (strong, nonatomic) TestCollectionCellViewModel *collectionCellViewModel;
@end

@implementation TestCellViewModel

- (instancetype)init {
    if (self = [super init]) {
        _tableCellViewModel = TestTableCellViewModel.new;
        _collectionCellViewModel = TestCollectionCellViewModel.new;
    }
    return self;
}

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [_tableCellViewModel.class instanceMethodSignatureForSelector:aSelector];
    } else
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [_collectionCellViewModel.class instanceMethodSignatureForSelector:aSelector];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_tableCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_tableCellViewModel];
        return;
    }
    if ([_collectionCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_collectionCellViewModel];
        return;
    }
}

@end
