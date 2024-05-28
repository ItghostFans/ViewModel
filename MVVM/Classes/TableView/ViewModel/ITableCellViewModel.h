//
//  ITableCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ITableCellViewModel <NSObject>

@property (weak, nonatomic, nullable, readonly) NSIndexPath *tableIndexPath;
@property (assign, nonatomic, readonly) CGSize tableCellSize;               // 最后一次tableCellHeightForWidth的size。

- (CGFloat)tableCellHeightForWidth:(CGFloat)width;                          // 在计算Table View Cell高度时调用。

#pragma mark - Subclass

@property (strong, nonatomic, nonnull, readonly) Class tableCellClass;               // TableView中展示的Cell类。

@end

NS_ASSUME_NONNULL_END
