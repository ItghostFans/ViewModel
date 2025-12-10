//
//  CollectionController.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionControllerViewModel;

@interface CollectionController : VMViewController

@property (weak, nonatomic, readonly) VMCollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic, readonly) VMCollectionView *collectionView;
@property (strong, nonatomic, nullable) CollectionControllerViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
