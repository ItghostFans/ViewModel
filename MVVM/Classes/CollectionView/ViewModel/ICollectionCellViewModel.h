//
//  ICollectionCellViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SectionViewModel;

@protocol ICollectionCellViewModel <NSObject>

@property (weak, nonatomic, nullable) NSIndexPath *collectionIndexPath;
@property (strong, nonatomic, nonnull, readonly) Class collectionCellClass;

@property (weak, nonatomic, nullable) SectionViewModel *collectionSectionViewModel;

- (CGSize)collectionCellSizeForSize:(CGSize)size;                          // 在计算Collection View Cell高度时调用。

@end

NS_ASSUME_NONNULL_END
