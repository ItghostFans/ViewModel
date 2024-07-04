//
//  WeakifyProxy.m
//  MVVM
//
//  Created by ItghostFan on 2024/5/31.
//

#import "WeakifyProxy.h"

@interface WeakifyProxy ()
@property (weak, nonatomic, nullable) id target;
@end

@implementation WeakifyProxy

- (instancetype)initWithTarget:(id)target {
    if (!target) {
        return nil;
    }
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([_target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:_target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_target methodSignatureForSelector:sel];
}

@end
