//
//  CollectionControllerViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/6/1.
//

#import <ViewModel/BaseViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionViewModel;

@interface CollectionControllerViewModel : BaseViewModel

@property (strong, nonatomic, nullable, readonly) CollectionViewModel *collectionViewModel;

- (instancetype)initWithCollectionViewModel:(CollectionViewModel * _Nullable)collectionViewModel;

#pragma mark - Update CollectionView

/// 更新（增/删/排序等）collectionViewModel的Section和Cell都务必在这里操作。
/// - Parameters:
///   - update: 更新Section和Cell的代码块，里面最好只执行SectionViewModel的一个更新方法，避免出现更新异常问题。
///   - completion: 更新完成的代码块。
///   - animationsEnabled: YES 带动画，NO 无动画。
- (void)collectionViewUpdates:(void(^)(void))updates
            animationsEnabled:(BOOL)animationsEnabled
                   completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
