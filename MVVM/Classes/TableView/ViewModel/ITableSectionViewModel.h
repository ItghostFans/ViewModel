//
//  ITableSectionViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ITableSectionViewModel <NSObject>

@property (assign, nonatomic) NSInteger tableSection;
@property (strong, nonatomic, nullable, readonly) Class tableHeaderClass;
@property (strong, nonatomic, nullable, readonly) Class tableFooterClass;

- (CGFloat)tableHeaderHeightForWidth:(CGFloat)width;
- (CGFloat)tableFooterHeightForWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
