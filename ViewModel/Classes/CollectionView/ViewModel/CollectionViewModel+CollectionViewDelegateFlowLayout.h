//
//  CollectionViewModel+CollectionViewDelegateFlowLayout.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import <ViewModel/CollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewModel (CollectionViewDelegateFlowLayout) <
#if TARGET_OS_IPHONE
UICollectionViewDelegateFlowLayout
#elif TARGET_OS_MAC
NSCollectionViewDelegateFlowLayout
#endif // #if TARGET_OS_IPHONE
>

@end

NS_ASSUME_NONNULL_END
