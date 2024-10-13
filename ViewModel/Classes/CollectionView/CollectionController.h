//
//  CollectionController.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionControllerViewModel;

@interface CollectionController : UIViewController

@property (weak, nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic, readonly) UICollectionView *collectionView;
@property (strong, nonatomic, nullable) CollectionControllerViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
