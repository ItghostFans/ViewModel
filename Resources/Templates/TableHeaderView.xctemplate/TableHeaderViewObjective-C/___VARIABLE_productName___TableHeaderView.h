//___FILEHEADER___

#import <ViewModel/TableHeaderView.h>

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___SectionViewModel;

@interface ___VARIABLE_productName___TableHeaderView : TableHeaderView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ___VARIABLE_productName___SectionViewModel *viewModel;
#pragma clang diagnostic pop

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(___VARIABLE_productName___SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
