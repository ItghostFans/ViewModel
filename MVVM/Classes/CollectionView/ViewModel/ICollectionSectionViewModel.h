//
//  ICollectionSectionViewModel.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionViewModel;

@protocol ICollectionSectionViewModel <NSObject>

@property (weak, nonatomic, nullable, readonly) NSIndexPath *collectionIndexPath;
@property (weak, nonatomic, nullable) CollectionViewModel *collectionViewModel;

@property (assign, nonatomic) CGFloat collectionMinimumLineSpacing;
@property (assign, nonatomic) CGFloat collectionMinimumInteritemSpacing;

#pragma mark - Subclass

@property (strong, nonatomic, nullable, readonly) Class collectionHeaderClass;
@property (strong, nonatomic, nullable, readonly) Class collectionFooterClass;

- (CGSize)collectionHeaderSizeForSize:(CGSize)size;
- (CGSize)collectionFooterSizeForSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
