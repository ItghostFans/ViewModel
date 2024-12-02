//
//  CollectionControllerViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CollectionViewModel;

@interface CollectionControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) CollectionViewModel *collectionViewModel;

- (instancetype)initWithCollectionViewModel:(CollectionViewModel *)collectionViewModel;

#pragma mark - Update CollectionView

/// 更新（增/删/排序等）collectionViewModel的Section和Cell都务必在这里操作。
/// - Parameters:
///   - update: 更新Section和Cell的代码块
///   - completion: 更新完成的代码块
- (void)collectionViewUpdate:(void(^ _Nullable)(void))update completion:(void (^ _Nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
