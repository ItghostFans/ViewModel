//
//  TestCellViewModel.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/1.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCellViewModel.h"
#import "TestTableViewModelCell.h"
#import "TestCollectionViewModelCell.h"

@implementation TestCellViewModel

@synthesize delegate = _delegate;

- (Class)tableCellClass {
    return TestTableViewModelCell.class;
}

- (Class)collectionCellClass {
    return TestCollectionViewModelCell.class;
}

@end
