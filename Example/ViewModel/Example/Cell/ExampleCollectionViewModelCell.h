//
//  ExampleCollectionViewModelCell.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/10.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import <ViewModel/CollectionViewModelCell.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleCollectionCellViewModel;

@interface ExampleCollectionViewModelCell : CollectionViewModelCell

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) ExampleCollectionCellViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
