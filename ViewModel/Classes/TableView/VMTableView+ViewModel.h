//
//  VMTableView+ViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/7/10.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMTableView (ViewModel)

@property (assign, nonatomic, readonly) VMTableViewRowAnimation rowAnimation;

- (void)performBatchUpdates:(void (^)(void))updates
               rowAnimation:(VMTableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
