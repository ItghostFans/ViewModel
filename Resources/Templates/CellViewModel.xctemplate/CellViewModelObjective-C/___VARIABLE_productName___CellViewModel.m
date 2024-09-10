//___FILEHEADER___

#import "___VARIABLE_productName___CellViewModel.h"
#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
#import "___VARIABLE_productName___TableCellViewModel.h"
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")
#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
#import "___VARIABLE_productName___CollectionCellViewModel.h"
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")

@interface ___VARIABLE_productName___CellViewModel ()

#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
@property (strong, nonatomic) ___VARIABLE_productName___TableCellViewModel *tableCellViewModel;
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")

#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
@property (strong, nonatomic) ___VARIABLE_productName___CollectionCellViewModel *collectionCellViewModel;
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")

@end

@implementation ___VARIABLE_productName___CellViewModel

- (instancetype)init {
    if (self = [super init]) {
#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
        _tableCellViewModel = ___VARIABLE_productName___TableCellViewModel.new;
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")
        
#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
        _collectionCellViewModel = ___VARIABLE_productName___CollectionCellViewModel.new;
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
    }
    return self;
}

#pragma mark - TableView

#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
- (Class)tableCellClass {
    return ___VARIABLE_productName___TableCellViewModel.class;
}
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")

#pragma mark - CollectionView

#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
- (Class)collectionCellClass {
    return ___VARIABLE_productName___CollectionCellViewModel.class;
}
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")

#pragma mark - Fowarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = nil;
#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___TableCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")
    
#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:aSelector]) {
        methodSignature = [___VARIABLE_productName___CollectionCellViewModel instanceMethodSignatureForSelector:aSelector];
    }
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
#if __has_include("___VARIABLE_productName___TableCellViewModel.h")
    if ([_tableCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_tableCellViewModel];
        return;
    }
#endif // #if __has_include("___VARIABLE_productName___TableCellViewModel.h")
    
#if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
    if ([_collectionCellViewModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_collectionCellViewModel];
        return;
    }
#endif // #if __has_include("___VARIABLE_productName___CollectionCellViewModel.h")
}

@end
