//
//  TestCollectionViewModelCell.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "CollectionViewModelCell.h"

NS_ASSUME_NONNULL_BEGIN

@class TestCollectionCellViewModel;

@interface TestCollectionViewModelCell : CollectionViewModelCell

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) TestCollectionCellViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
