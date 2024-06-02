//
//  TestSectionViewModel.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/2.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestSectionViewModel.h"

#import "SectionViewModel+TableView.h"
#import "SectionViewModel+CollectionView.h"

#import "TestTableHeaderView.h"
#import "TestTableFooterView.h"
#import "TestCollectionHeaderView.h"
#import "TestCollectionFooterView.h"

@implementation TestSectionViewModel

@synthesize delegate = _delegate;

#pragma mark - TableView

- (Class)tableHeaderClass {
    return TestTableHeaderView.class;
}

- (Class)tableFooterClass {
    return TestTableFooterView.class;
}

#pragma mark - CollectionView

- (Class)collectionHeaderClass {
    return TestCollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    return TestCollectionFooterView.class;
}

@end
