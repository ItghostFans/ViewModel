//___FILEHEADER___

#import "CellViewModel+TableView.h"
#import "CellViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class ___VARIABLE_productName___CellViewModel;

@protocol I___VARIABLE_productName___CellViewModelDelegate <ICellViewModelDelegate>
@end

@interface ___VARIABLE_productName___CellViewModel : CellViewModel

@property (weak, nonatomic, nullable) id<I___VARIABLE_productName___CellViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
