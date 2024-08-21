//___FILEHEADER___

#import <ViewModel/TableControllerViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___TableControllerViewModel;

@protocol I___VARIABLE_productName___TableControllerViewModelDelegate <IBaseViewModelDelegate>
@end

@interface ___VARIABLE_productName___TableControllerViewModel : TableControllerViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<I___VARIABLE_productName___TableControllerViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
