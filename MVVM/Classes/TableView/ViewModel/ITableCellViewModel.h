//
//  ITableCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TableViewModel;

@protocol ITableCellViewModel <NSObject>

@property (weak, nonatomic, nullable, readonly) NSIndexPath *tableIndexPath;

@property (weak, nonatomic, nullable) TableViewModel *tableViewModel;

- (CGFloat)tableCellHeightForWidth:(CGFloat)width;

#pragma mark - Subclass

@property (strong, nonatomic, nonnull, readonly) Class tableCellClass;               // TableView中展示的Cell类。

@end

NS_ASSUME_NONNULL_END
