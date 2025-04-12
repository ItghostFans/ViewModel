//
//  AutoSectionViewModel.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/26.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "AutoSectionViewModel.h"

#import "SectionViewModel+TableView.h"
#import "SectionViewModel+CollectionView.h"

#import "AutoTableHeaderView.h"
#import "AutoTableFooterView.h"
#import "AutoCollectionHeaderView.h"
#import "AutoCollectionFooterView.h"

@implementation AutoSectionViewModel

#pragma mark - TableView

- (Class)tableHeaderClass {
    return AutoTableHeaderView.class;
}

- (Class)tableFooterClass {
    return AutoTableFooterView.class;
}

#pragma mark - CollectionView

- (Class)collectionHeaderClass {
    return AutoCollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    return AutoCollectionFooterView.class;
}

@end
