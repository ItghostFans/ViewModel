//___FILEHEADER___

#import <ViewModel/SectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___SectionViewModel;

@protocol I___VARIABLE_productName___SectionViewModelDelegate <IBaseViewModelDelegate>
@end

@interface ___VARIABLE_productName___SectionViewModel : SectionViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<I___VARIABLE_productName___SectionViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
