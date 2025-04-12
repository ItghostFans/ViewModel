//
//  AutoCellViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "AutoCellViewModel.h"
#import "AutoTableViewModelCell.h"
#import "AutoCollectionViewModelCell.h"

@interface AutoCellViewModel ()
@property (strong, nonatomic) AutoTableViewModelCell *tableCellViewModel;
@property (strong, nonatomic) AutoCollectionViewModelCell *collectionCellViewModel;
@end

@implementation AutoCellViewModel

- (instancetype)init {
    if (self = [super init]) {
        _tableCellViewModel = AutoTableViewModelCell.new;
        _collectionCellViewModel = AutoCollectionViewModelCell.new;
    }
    return self;
}

#pragma mark - TableView

- (Class)tableCellClass {
    return AutoTableViewModelCell.class;
}

#pragma mark - CollectionView

- (Class)collectionCellClass {
    return AutoCollectionViewModelCell.class;
}

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [AutoTableViewModelCell instanceMethodSignatureForSelector:aSelector];
    } else
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [AutoCollectionViewModelCell instanceMethodSignatureForSelector:aSelector];
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
