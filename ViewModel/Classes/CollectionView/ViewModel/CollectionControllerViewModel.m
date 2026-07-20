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

- (instancetype)initWithCollectionViewModel:(CollectionViewModel * _Nullable)collectionViewModel {
    if (self = [self init]) {
        if (!collectionViewModel) {
            _collectionViewModel = CollectionViewModel.new;
            [_collectionViewModel.sectionViewModels addViewModel:SectionViewModel.new];
        } else {
            _collectionViewModel = collectionViewModel;
        }
    }
    return self;
}

#pragma mark - Update CollectionView

- (void)collectionViewUpdate:(void(^)(void))update
           animationsEnabled:(BOOL)animationsEnabled
                  completion:(void (^)(BOOL finished))completion {
    if (self.collectionViewModel.collectionView) {
        [self.collectionViewModel.collectionView performBatchUpdates:update completion:completion animationsEnabled:animationsEnabled];
    } else {
        if (update) {update();}
        if (completion) {completion(YES);}
    }
}

@end
