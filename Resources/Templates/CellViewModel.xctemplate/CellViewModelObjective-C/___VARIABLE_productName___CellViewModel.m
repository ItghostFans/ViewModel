//___FILEHEADER___

#import "___VARIABLE_productName___CellViewModel.h"
#import "___VARIABLE_productName___TableViewModelCell.h"
#import "___VARIABLE_productName___CollectionViewModelCell.h"

@interface ___VARIABLE_productName___CellViewModel ()
@property (strong, nonatomic) ___VARIABLE_productName___TableViewModelCell *tableCellViewModel;
@property (strong, nonatomic) ___VARIABLE_productName___CollectionViewModelCell *collectionCellViewModel;
@end

@implementation ___VARIABLE_productName___CellViewModel

- (instancetype)init {
    if (self = [super init]) {
        _tableCellViewModel = ___VARIABLE_productName___TableViewModelCell.new;
        _collectionCellViewModel = ___VARIABLE_productName___CollectionViewModelCell.new;
    }
    return self;
}

#pragma mark - TableView

- (Class)tableCellClass {
    return ___VARIABLE_productName___TableViewModelCell.class;
}

#pragma mark - CollectionView

- (Class)collectionCellClass {
    return ___VARIABLE_productName___CollectionViewModelCell.class;
}

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___TableViewModelCell instanceMethodSignatureForSelector:aSelector];
    } else
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___CollectionViewModelCell instanceMethodSignatureForSelector:aSelector];
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
