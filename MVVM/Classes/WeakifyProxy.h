//
//  WeakifyProxy.h
//  MVVM
//
//  Created by ItghostFan on 2024/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakifyProxy : NSProxy

@property (weak, nonatomic, nullable, readonly) id target;

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
