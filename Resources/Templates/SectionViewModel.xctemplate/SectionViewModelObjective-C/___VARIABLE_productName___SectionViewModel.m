//___FILEHEADER___

#import "___VARIABLE_productName___SectionViewModel.h"

#import <ViewModel/SectionViewModel+TableView.h>
#import <ViewModel/SectionViewModel+CollectionView.h>

#import "___VARIABLE_productName___TableHeaderView.h"
#import "___VARIABLE_productName___TableFooterView.h"
#import "___VARIABLE_productName___CollectionHeaderView.h"
#import "___VARIABLE_productName___CollectionFooterView.h"

@implementation ___VARIABLE_productName___SectionViewModel

#pragma mark - TableView

- (Class)tableHeaderClass {
    return ___VARIABLE_productName___TableHeaderView.class;
}

- (Class)tableFooterClass {
    return ___VARIABLE_productName___TableFooterView.class;
}

#pragma mark - CollectionView

- (Class)collectionHeaderClass {
    return ___VARIABLE_productName___CollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    return ___VARIABLE_productName___CollectionFooterView.class;
}

@end
