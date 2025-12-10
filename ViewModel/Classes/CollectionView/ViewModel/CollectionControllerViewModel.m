//
//  CollectionControllerViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "CollectionControllerViewModel.h"

#import <VMOS/VMKit.h>
#import <ViewModel/VMCollectionView+ViewModel.h>
#import <ViewModel/CollectionViewModel.h>

@implementation CollectionControllerViewModel

- (instancetype)initWithCollectionViewModel:(CollectionViewModel *)collectionViewModel {
    if (self = [self init]) {
        _collectionViewModel = collectionViewModel;
    }
    return self;
}

#pragma mark - Update CollectionView

- (void)collectionViewUpdate:(void(^)(void))update completion:(void (^)(BOOL finished))completion {
    if (self.collectionViewModel.collectionView) {
        [self.collectionViewModel.collectionView performBatchUpdates:update completion:completion animationsEnabled:NO];
    } else {
        if (update) {update();}
        if (completion) {completion(YES);}
    }
}

@end
