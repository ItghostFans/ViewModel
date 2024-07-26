//
//  CollectionViewModel.h
//  ViewModel
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ICollectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@property (strong, nonatomic) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
