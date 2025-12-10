//
//  TableViewModel+TableViewDataSource.h
//  ViewModel
//
//  Created by ItghostFan on 2024/5/30.
//

#import <ViewModel/TableViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewModel (TableViewDataSource) <
#if TARGET_OS_IPHONE
UITableViewDataSource
#elif TARGET_OS_MAC
NSTableViewDataSource
#endif // #if TARGET_OS_IPHONE
>

@end

NS_ASSUME_NONNULL_END
