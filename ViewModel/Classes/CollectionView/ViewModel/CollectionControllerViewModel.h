//
//  CollectionControllerViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CollectionViewModel;

@interface CollectionControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) CollectionViewModel *collectionViewModel;

- (instancetype)initWithCollectionViewModel:(CollectionViewModel *)collectionViewModel;

#pragma mark - Update CollectionView

- (void)collectionViewUpdate:(void(^)(void))update completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
