//___FILEHEADER___

#import "CollectionFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___SectionViewModel;

@interface ___VARIABLE_productName___CollectionFooterView : CollectionFooterView

@property (weak, nonatomic, nullable) ___VARIABLE_productName___SectionViewModel *viewModel;

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(___VARIABLE_productName___SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END