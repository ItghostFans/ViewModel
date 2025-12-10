//
//  ColumnRowFlowLayout.h
//  ViewModel
//
//  Created by ItghostFan on 2024/7/3.
//

#import <VMOS/VMKit.h>

#import <ViewModel/VMCollectionViewFlowLayout+ViewModel.h>
#import <ViewModel/CollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColumnRowFlowLayout : VMCollectionViewFlowLayout

@property (weak, nonatomic, nullable) CollectionViewModel *viewModel;
@property (assign, nonatomic) NSUInteger columnCount;
@property (assign, nonatomic) NSUInteger rowCount;
@property (assign, nonatomic) VMEdgeInsets contentInset;

@end

NS_ASSUME_NONNULL_END
