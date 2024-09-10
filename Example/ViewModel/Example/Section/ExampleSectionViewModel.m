//
//  ExampleSectionViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "ExampleSectionViewModel.h"

#import <ViewModel/SectionViewModel+TableView.h>
#import <ViewModel/SectionViewModel+CollectionView.h>

#import "ExampleTableHeaderView.h"
#import "ExampleTableFooterView.h"
#import "ExampleCollectionHeaderView.h"
#import "ExampleCollectionFooterView.h"

@implementation ExampleSectionViewModel

#pragma mark - TableView

- (Class)tableHeaderClass {
    return ExampleTableHeaderView.class;
}

- (Class)tableFooterClass {
    return ExampleTableFooterView.class;
}

#pragma mark - CollectionView

- (Class)collectionHeaderClass {
    return ExampleCollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    return ExampleCollectionFooterView.class;
}

@end
