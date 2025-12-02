//
//  CollectionViewModelCell.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@interface CollectionViewModelCell : VMCollectionViewCell

@property (weak, nonatomic, nullable) CellViewModel *viewModel;

#pragma mark - Subclass

- (void)reloadIndexPath;

+ (CGSize)cellSizeForSize:(CGSize)size viewModel:(CellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
