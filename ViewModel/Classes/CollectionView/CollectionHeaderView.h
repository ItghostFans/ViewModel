//
//  CollectionHeaderView.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SectionViewModel;

@interface CollectionHeaderView : VMCollectionReusableView

@property (weak, nonatomic, nullable) SectionViewModel *viewModel;

#pragma mark - Subclass

- (void)reloadIndexPath;

+ (CGSize)headerSizeForSize:(CGSize)size viewModel:(SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
