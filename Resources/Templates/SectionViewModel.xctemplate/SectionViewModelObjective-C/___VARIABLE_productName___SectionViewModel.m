//___FILEHEADER___

#import "___VARIABLE_productName___SectionViewModel.h"

#import <ViewModel/SectionViewModel+TableView.h>
#import <ViewModel/SectionViewModel+CollectionView.h>

#if __has_include("___VARIABLE_productName___TableHeaderView.h")
#import "___VARIABLE_productName___TableHeaderView.h"
#endif // #if __has_include("___VARIABLE_productName___TableHeaderView.h")
#if __has_include("___VARIABLE_productName___TableFooterView.h")
#import "___VARIABLE_productName___TableFooterView.h"
#endif // #if __has_include("___VARIABLE_productName___TableFooterView.h")
#if __has_include("___VARIABLE_productName___CollectionHeaderView.h")
#import "___VARIABLE_productName___CollectionHeaderView.h"
#endif // #if __has_include("___VARIABLE_productName___CollectionHeaderView.h")
#if __has_include("___VARIABLE_productName___CollectionFooterView.h")
#import "___VARIABLE_productName___CollectionFooterView.h"
#endif // #if __has_include("___VARIABLE_productName___CollectionFooterView.h")

@implementation ___VARIABLE_productName___SectionViewModel

#pragma mark - TableView

#if __has_include("___VARIABLE_productName___TableHeaderView.h")
- (Class)tableHeaderClass {
    return ___VARIABLE_productName___TableHeaderView.class;
}
#endif // #if __has_include("___VARIABLE_productName___TableHeaderView.h")

#if __has_include("___VARIABLE_productName___TableFooterView.h")
- (Class)tableFooterClass {
    return ___VARIABLE_productName___TableFooterView.class;
}
#endif // #if __has_include("___VARIABLE_productName___TableFooterView.h")

#pragma mark - CollectionView

#if __has_include("___VARIABLE_productName___CollectionHeaderView.h")
- (Class)collectionHeaderClass {
    return ___VARIABLE_productName___CollectionHeaderView.class;
}
#endif // #if __has_include("___VARIABLE_productName___CollectionHeaderView.h")

#if __has_include("___VARIABLE_productName___CollectionFooterView.h")
- (Class)collectionFooterClass {
    return ___VARIABLE_productName___CollectionFooterView.class;
}
#endif // #if __has_include("___VARIABLE_productName___CollectionFooterView.h")

@end
