//___FILEHEADER___

#import "___VARIABLE_productName___CellViewModel.h"
#import "___VARIABLE_productName___TableViewModelCell.h"
#import "___VARIABLE_productName___CollectionViewModelCell.h"

@implementation ___VARIABLE_productName___CellViewModel

@synthesize delegate = _delegate;

#pragma mark - TableView

- (Class)tableCellClass {
    return ___VARIABLE_productName___TableViewModelCell.class;
}

#pragma mark - CollectionView

- (Class)collectionCellClass {
    return ___VARIABLE_productName___CollectionViewModelCell.class;
}

@end
