//
//  TestAnotherCollectionViewModelCell.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/11/22.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import <ViewModel/CollectionViewModelCell.h>

NS_ASSUME_NONNULL_BEGIN

@class TestAnotherCollectionCellViewModel;

@interface TestAnotherCollectionViewModelCell : CollectionViewModelCell

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) TestAnotherCollectionCellViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
