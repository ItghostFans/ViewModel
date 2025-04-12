//
//  AutoTableViewModelCell.h
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/9/7.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import <ViewModel/TableViewModelCell.h>

NS_ASSUME_NONNULL_BEGIN

@class AutoTableCellViewModel;

@interface AutoTableViewModelCell : TableViewModelCell

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (weak, nonatomic, nullable) AutoTableCellViewModel *viewModel;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
