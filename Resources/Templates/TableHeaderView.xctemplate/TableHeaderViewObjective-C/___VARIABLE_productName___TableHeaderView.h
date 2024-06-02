//___FILEHEADER___

#import "TableHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___SectionViewModel;

@interface ___VARIABLE_productName___TableHeaderView : TableHeaderView

@property (weak, nonatomic, nullable) ___VARIABLE_productName___SectionViewModel *viewModel;

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(___VARIABLE_productName___SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END