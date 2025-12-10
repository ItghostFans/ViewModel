//
//  TableViewModel+TableViewDelegate.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import <ViewModel/TableViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewModel (TableViewDelegate) <
#if TARGET_OS_IPHONE
UITableViewDelegate
#elif TARGET_OS_MAC
NSTableViewDelegate
#endif // #if TARGET_OS_IPHONE
>

@end

NS_ASSUME_NONNULL_END
