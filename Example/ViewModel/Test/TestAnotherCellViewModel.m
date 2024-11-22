//
//  TestAnotherCellViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/11/22.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestAnotherCellViewModel.h"
#if __has_include("TestAnotherTableCellViewModel.h")
#import "TestAnotherTableCellViewModel.h"
#endif // #if __has_include("TestAnotherTableCellViewModel.h")
#if __has_include("TestAnotherCollectionCellViewModel.h")
#import "TestAnotherCollectionCellViewModel.h"
#endif // #if __has_include("TestAnotherCollectionCellViewModel.h")

@interface TestAnotherCellViewModel ()

#if __has_include("TestAnotherTableCellViewModel.h")
@property (strong, nonatomic) TestAnotherTableCellViewModel *tableCellViewModel;
#endif // #if __has_include("TestAnotherTableCellViewModel.h")

#if __has_include("TestAnotherCollectionCellViewModel.h")
@property (strong, nonatomic) TestAnotherCollectionCellViewModel *collectionCellViewModel;
#endif // #if __has_include("TestAnotherCollectionCellViewModel.h")

@end

@implementation TestAnotherCellViewModel

- (instancetype)init {
    if (self = [super init]) {
#if __has_include("TestAnotherTableCellViewModel.h")
        _tableCellViewModel = TestAnotherTableCellViewModel.new;
#endif // #if __has_include("TestAnotherTableCellViewModel.h")
        
#if __has_include("TestAnotherCollectionCellViewModel.h")
        _collectionCellViewModel = TestAnotherCollectionCellViewModel.new;
#endif // #if __has_include("TestAnotherCollectionCellViewModel.h")
    }
    return self;
}

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
#if __has_include("TestAnotherTableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [TestAnotherTableCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("TestAnotherTableCellViewModel.h")
    
#if __has_include("TestAnotherCollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [TestAnotherCollectionCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("TestAnotherCollectionCellViewModel.h")
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
#if __has_include("TestAnotherTableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_tableCellViewModel];
        return;
    }
#endif // #if __has_include("TestAnotherTableCellViewModel.h")
    
#if __has_include("TestAnotherCollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_collectionCellViewModel];
        return;
    }
#endif // #if __has_include("TestAnotherCollectionCellViewModel.h")
}

@end
