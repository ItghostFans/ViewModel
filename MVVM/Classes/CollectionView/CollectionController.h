//
//  CollectionController.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionViewModel;

@interface CollectionController : UIViewController

@property (strong, nonatomic, readonly) UICollectionView *collectionView;

@property (strong, nonatomic, nullable) CollectionViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
