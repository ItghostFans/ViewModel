//
//  CollectionViewModel+CollectionViewDelegate.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import <ViewModel/CollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewModel (CollectionViewDelegate) <
#if TARGET_OS_IPHONE
UICollectionViewDelegate
#elif TARGET_OS_MAC
NSCollectionViewDelegate
#endif // #if TARGET_OS_IPHONE
>

@end

NS_ASSUME_NONNULL_END
