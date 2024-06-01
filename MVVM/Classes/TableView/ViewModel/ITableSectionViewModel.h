//
//  ITableSectionViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TableViewModel;

@protocol ITableSectionViewModel <NSObject>

@property (assign, nonatomic, readonly) NSInteger tableSection;
@property (weak, nonatomic, nullable) TableViewModel *tableViewModel;

@property (strong, nonatomic, nullable, readonly) Class tableHeaderClass;
@property (strong, nonatomic, nullable, readonly) Class tableFooterClass;

- (CGFloat)tableHeaderHeightForWidth:(CGFloat)width;
- (CGFloat)tableFooterHeightForWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
