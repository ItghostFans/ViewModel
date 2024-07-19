//
//  ColumnRowFlowLayout.h
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import <UIKit/UIKit.h>

#import "UICollectionViewFlowLayout+ViewModel.h"
#import "CollectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColumnRowFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic, nullable) CollectionViewModel *viewModel;
@property (assign, nonatomic) NSUInteger columnCount;
@property (assign, nonatomic) NSUInteger rowCount;

@end

NS_ASSUME_NONNULL_END
