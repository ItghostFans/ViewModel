//
//  CollectionViewModel+Private.h
//  Pods
//
//  Created by ItghostFan on 2026/9/11.
//

#import <ViewModel/CollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewModel ()

@property (copy, nonatomic, nullable) void(^batchCompletion)(BOOL finished);

@end

NS_ASSUME_NONNULL_END
