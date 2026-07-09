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

/// 更新列表。
/// - Parameters:
///   - updates: 更新的代码段。
///       注意不要在不要在这里触发TableView的数据刷新，否则会导致Exception。
///   - rowAnimation: 执行更新想要执行的动画方式。
///   - completion: 更新回调。
- (void)performBatchUpdates:(void (^)(void))updates
               rowAnimation:(VMTableViewRowAnimation)rowAnimation
                 completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
