//
//  TestCollectionCellViewModel.m
//  MVVM_Example
//
//  Created by ItghostFan on 2024/6/1.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionCellViewModel.h"
#import "TestCollectionViewModelCell.h"

@implementation TestCollectionCellViewModel

- (Class)collectionCellClass {
    return TestCollectionViewModelCell.class;
}

@end
