//
//  TableViewModel+UIScrollViewDelegate.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import <ViewModel/TableViewModel.h>

#if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

@interface TableViewModel (UIScrollViewDelegate) <UIScrollViewDelegate>

@end

NS_ASSUME_NONNULL_END

#elif TARGET_OS_MAC
#endif // #if TARGET_OS_IPHONE
