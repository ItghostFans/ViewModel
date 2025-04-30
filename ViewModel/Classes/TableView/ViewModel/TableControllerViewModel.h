//
//  TableControllerViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TableViewModel;

@interface TableControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) TableViewModel *tableViewModel;

- (instancetype)initWithTableViewModel:(TableViewModel * _Nonnull)tableViewModel;

#pragma mark - Update TableView

/// 更新（增/删/排序等）tableViewModel的Section和Cell都务必在这里操作。
/// - Parameters:
///   - update: 更新Section和Cell的代码块
///   - completion: 更新完成的代码块
- (void)tableViewUpdate:(void(^ _Nullable)(void))update completion:(void (^ _Nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
