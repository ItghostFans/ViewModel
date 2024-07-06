//
//  CollectionControllerViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "CollectionControllerViewModel.h"

@implementation CollectionControllerViewModel

- (instancetype)initWithCollectionViewModel:(CollectionViewModel *)collectionViewModel {
    if (self = [super init]) {
        _collectionViewModel = collectionViewModel;
    }
    return self;
}

@end
