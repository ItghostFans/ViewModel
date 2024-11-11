//
//  WeakifyProxy.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "WeakifyProxy.h"

@interface WeakifyProxy () <NSObject>
@property (weak, nonatomic, nullable) id<NSObject> target;
@end

@implementation WeakifyProxy

- (instancetype)initWithTarget:(id)target {
    if (!target) {
        return nil;
    }
    _target = target;
    return self;
}

- (BOOL)respondsToSelector:(SEL)sel {
    return [_target respondsToSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([_target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:_target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *methodSignature;
    if ([_target respondsToSelector:sel]) {
        methodSignature = [_target.class instanceMethodSignatureForSelector:sel];
    }
    return methodSignature;
}

@end
