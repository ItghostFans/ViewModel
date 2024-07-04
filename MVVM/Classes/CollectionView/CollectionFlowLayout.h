//
//  CollectionFlowLayout.h
//  MVVM
//
//  Created by ItghostFan on 2024/7/3.
//

#import <UIKit/UIKit.h>

#import "CollectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic, nullable) CollectionViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
