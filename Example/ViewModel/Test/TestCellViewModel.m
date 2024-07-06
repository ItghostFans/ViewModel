//
//  TestCellViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCellViewModel.h"
#import "TestTableViewModelCell.h"
#import "TestCollectionViewModelCell.h"

@implementation TestCellViewModel

@synthesize delegate = _delegate;

#pragma mark - TableView

- (Class)tableCellClass {
    return TestTableViewModelCell.class;
}

#pragma mark - CollectionView

- (Class)collectionCellClass {
    return TestCollectionViewModelCell.class;
}

@end
