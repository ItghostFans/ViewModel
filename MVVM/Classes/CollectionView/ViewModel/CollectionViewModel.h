//
//  CollectionViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

#import "BaseViewModel.h"

#import "SectionViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@protocol ICollectionViewModelDelegate <UICollectionViewDelegate, IBaseViewModelDelegate>

@end

@interface CollectionViewModel : BaseViewModel

@property (weak, nonatomic, nullable) id<ICollectionViewModelDelegate> delegate;

@property (strong, nonatomic) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
