//___FILEHEADER___

#import "CollectionHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___SectionViewModel;

@interface ___VARIABLE_productName___CollectionHeaderView : CollectionHeaderView

@property (weak, nonatomic, nullable) ___VARIABLE_productName___SectionViewModel *viewModel;

+ (CGSize)headerSizeForSize:(CGSize *)size viewModel:(___VARIABLE_productName___SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END