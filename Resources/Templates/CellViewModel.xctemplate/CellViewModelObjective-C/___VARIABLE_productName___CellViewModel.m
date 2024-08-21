//___FILEHEADER___

#import "___VARIABLE_productName___CellViewModel.h"
#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
#import "___VARIABLE_productName___TableViewModelCell.h"
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")
#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
#import "___VARIABLE_productName___CollectionViewModelCell.h"
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")

@interface ___VARIABLE_productName___CellViewModel ()

#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
@property (strong, nonatomic) ___VARIABLE_productName___TableViewModelCell *tableCellViewModel;
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")

#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
@property (strong, nonatomic) ___VARIABLE_productName___CollectionViewModelCell *collectionCellViewModel;
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")

@end

@implementation ___VARIABLE_productName___CellViewModel

- (instancetype)init {
    if (self = [super init]) {
#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
        _tableCellViewModel = ___VARIABLE_productName___TableViewModelCell.new;
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")
        
#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
        _collectionCellViewModel = ___VARIABLE_productName___CollectionViewModelCell.new;
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
    }
    return self;
}

#pragma mark - TableView

#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
- (Class)tableCellClass {
    return ___VARIABLE_productName___TableViewModelCell.class;
}
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")

#pragma mark - CollectionView

#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
- (Class)collectionCellClass {
    return ___VARIABLE_productName___CollectionViewModelCell.class;
}
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___TableViewModelCell instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")
    
#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___CollectionViewModelCell instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
#if __has_include("___VARIABLE_productName___TableViewModelCell.h")
    if ([_tableCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_tableCellViewModel];
        return;
    }
#endif // #if __has_include("___VARIABLE_productName___TableViewModelCell.h")
    
#if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
    if ([_collectionCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_collectionCellViewModel];
        return;
    }
#endif // #if __has_include("___VARIABLE_productName___CollectionViewModelCell.h")
}

@end
