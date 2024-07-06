//
//  CollectionViewModelCell.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@interface CollectionViewModelCell : UICollectionViewCell

@property (weak, nonatomic, nullable) CellViewModel *viewModel;

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(CellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
