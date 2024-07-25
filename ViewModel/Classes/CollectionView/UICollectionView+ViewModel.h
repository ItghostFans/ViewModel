//
//  UICollectionView+ViewModel.h
//  ViewModel
//
//  Created by ItghostFan on 2024/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ViewModel)

- (void)performBatchUpdates:(void (^)(void))updates
                 completion:(void (^)(BOOL))completion
          animationsEnabled:(BOOL)animationsEnabled;

@end

NS_ASSUME_NONNULL_END
