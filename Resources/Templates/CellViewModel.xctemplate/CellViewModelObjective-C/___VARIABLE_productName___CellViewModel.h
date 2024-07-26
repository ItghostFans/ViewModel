//___FILEHEADER___

#import "CellViewModel+TableView.h"
#import "CellViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___CellViewModel;

@protocol I___VARIABLE_productName___CellViewModelDelegate <ICellViewModelDelegate>
@end

@interface ___VARIABLE_productName___CellViewModel : CellViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) id<I___VARIABLE_productName___CellViewModelDelegate> delegate;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
