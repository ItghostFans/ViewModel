//
//  CollectionControllerViewModel.m
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "CollectionControllerViewModel.h"

#import <VMOS/VMKit.h>
#import <ViewModel/VMCollectionView+ViewModel.h>
#import <ViewModel/CollectionViewModel+Private.h>

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

- (void)collectionViewUpdates:(void(^)(void))updates
            animationsEnabled:(BOOL)animationsEnabled
                   completion:(void (^)(BOOL finished))completion {
//    if (self.collectionViewModel.collectionView) {
//        [self.collectionViewModel.collectionView performBatchUpdates:updates completion:completion animationsEnabled:animationsEnabled];
//    } else {
    self.collectionViewModel.batchCompletion = completion;
    if (updates) {updates();}
//    if (completion) {completion(YES);}
//    }
}

@end
