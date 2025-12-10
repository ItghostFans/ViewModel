//
//  CollectionFooterView.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SectionViewModel;

@interface CollectionFooterView : VMCollectionReusableView

@property (weak, nonatomic, nullable) SectionViewModel *viewModel;

#pragma mark - Subclass

- (void)reloadIndexPath;

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
