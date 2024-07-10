//
//  UITableView+ViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ViewModel)

@property (assign, nonatomic, readonly) UITableViewRowAnimation rowAnimation;

- (void)performBatchUpdates:(void (^)(void))updates
               rowAnimation:(UITableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL))completion;

@end

NS_ASSUME_NONNULL_END
