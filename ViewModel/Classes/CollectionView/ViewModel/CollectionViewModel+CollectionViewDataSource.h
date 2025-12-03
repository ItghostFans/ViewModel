//
//  CollectionViewModel+CollectionViewDataSource.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import <ViewModel/CollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewModel (CollectionViewDataSource)
#if TARGET_OS_IPHONE
<UICollectionViewDataSource>
#elif TARGET_OS_MAC
<NSCollectionViewDataSource>
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
