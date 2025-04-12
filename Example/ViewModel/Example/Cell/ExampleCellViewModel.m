//
//  ExampleCellViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "ExampleCellViewModel.h"
#if __has_include("ExampleTableCellViewModel.h")
#import "ExampleTableCellViewModel.h"
#endif // #if __has_include("ExampleTableCellViewModel.h")
#if __has_include("ExampleCollectionCellViewModel.h")
#import "ExampleCollectionCellViewModel.h"
#endif // #if __has_include("ExampleCollectionCellViewModel.h")

@interface ExampleCellViewModel ()

#if __has_include("ExampleTableCellViewModel.h")
@property (strong, nonatomic) ExampleTableCellViewModel *tableCellViewModel;
#endif // #if __has_include("ExampleTableCellViewModel.h")

#if __has_include("ExampleCollectionCellViewModel.h")
@property (strong, nonatomic) ExampleCollectionCellViewModel *collectionCellViewModel;
#endif // #if __has_include("ExampleCollectionCellViewModel.h")

@end

@implementation ExampleCellViewModel

- (instancetype)init {
    if (self = [super init]) {
#if __has_include("ExampleTableCellViewModel.h")
        _tableCellViewModel = ExampleTableCellViewModel.new;
#endif // #if __has_include("ExampleTableCellViewModel.h")
        
#if __has_include("ExampleCollectionCellViewModel.h")
        _collectionCellViewModel = ExampleCollectionCellViewModel.new;
#endif // #if __has_include("ExampleCollectionCellViewModel.h")
    }
    return self;
}

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
#if __has_include("ExampleTableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [ExampleTableCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("ExampleTableCellViewModel.h")
    
#if __has_include("ExampleCollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [ExampleCollectionCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("ExampleCollectionCellViewModel.h")
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
#if __has_include("ExampleTableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_tableCellViewModel];
        return;
    }
#endif // #if __has_include("ExampleTableCellViewModel.h")
    
#if __has_include("ExampleCollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_collectionCellViewModel];
        return;
    }
#endif // #if __has_include("ExampleCollectionCellViewModel.h")
}

@end
