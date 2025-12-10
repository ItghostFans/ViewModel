//
//  CollectionViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

#import <ViewModel/BaseViewModel.h>
#import <ViewModel/SectionViewModel+CollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;
@class VMCollectionView;

@protocol ICollectionViewModelDelegate <
#if TARGET_OS_IPHONE
UICollectionViewDelegate,
#elif TARGET_OS_MAC
NSCollectionViewDelegate,
#endif // #if TARGET_OS_IPHONE
IBaseViewModelDelegate>

@end

@interface CollectionViewModel : BaseViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<ICollectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@property (strong, nonatomic) BaseViewModels *sectionViewModels;

@property (weak, nonatomic, nullable) VMCollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
