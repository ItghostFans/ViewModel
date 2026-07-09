//
//  NSObject+ViewModel.m
//  Pods
//
//  Created by ItghostFan on 2026/1/13.
//

#import "NSObject+ViewModel.h"

#import <VMOS/VMWeakifyProxy.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation NSObject (ViewModel)

- (RACDisposable *)vm_arrayChangesForKeyPath:(NSString *)keyPath
                                      object:(NSObject *)object
                                    observer:(__weak NSObject *)observer
                                     context:(__weak NSObject * _Nullable)context
                                  settingSel:(SEL)settingSel
                                insertionSel:(SEL)insertionSel
                                  removalSel:(SEL)removalSel
                              replacementSel:(SEL)replacementSel {
    @weakify(observer, context);
    /// observer会导致强引用，所以退出时，一定要dispose。
    return [[[object rac_valuesAndChangesForKeyPath:keyPath
                                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                           observer:observer] takeUntil:observer.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(observer, context);
        NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        NSMutableArray<__kindof NSNumber *> *indexes = NSMutableArray.new;
        [(NSIndexSet *)change[NSKeyValueChangeIndexesKey] enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [indexes addObject:@(idx)];
        }];
        NSArray *news = change[NSKeyValueChangeNewKey];
        if ([news isKindOfClass:NSNull.class]) {
            news = nil;
        }
        NSArray *olds = change[NSKeyValueChangeOldKey];
        if ([olds isKindOfClass:NSNull.class]) {
            olds = nil;
        }
        NSInteger paramIndex = 2;
        NSInvocation *invocation = nil;
        switch (valueChange) {
            case NSKeyValueChangeSetting: {
                invocation = [self vm_invocationOfObject:observer selector:settingSel];
                [invocation setArgument:(void *)&news atIndex:paramIndex++];
                [invocation setArgument:(void *)&context atIndex:paramIndex++];
                break;
            }
            case NSKeyValueChangeInsertion: {
                invocation = [self vm_invocationOfObject:observer selector:insertionSel];
                [invocation setArgument:(void *)&news atIndex:paramIndex++];
                [invocation setArgument:(void *)&context atIndex:paramIndex++];
                [invocation setArgument:(void *)&indexes atIndex:paramIndex++];
                break;
            }
            case NSKeyValueChangeRemoval: {
                invocation = [self vm_invocationOfObject:observer selector:removalSel];
                [invocation setArgument:(void *)&olds atIndex:paramIndex++];
                [invocation setArgument:(void *)&context atIndex:paramIndex++];
                [invocation setArgument:(void *)&indexes atIndex:paramIndex++];
                break;
            }
            case NSKeyValueChangeReplacement: {
                invocation = [self vm_invocationOfObject:observer selector:replacementSel];
                [invocation setArgument:(void *)&news atIndex:paramIndex++];
                [invocation setArgument:(void *)&context atIndex:paramIndex++];
                [invocation setArgument:(void *)&indexes atIndex:paramIndex++];
                break;
            }
            default: {
                break;
            }
        }
        [invocation invoke];
        NSLog(@"Fuck Invoke");
    } error:^(NSError * _Nullable error) {
        NSLog(@"Fuck Error");
    } completed:^{
        NSLog(@"Fuck Completion");
    }];
}

- (nullable NSInvocation *)vm_invocationOfObject:(NSObject *)object selector:(SEL)selector {
    NSMethodSignature *methodSignature = [object.class instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = object;
    invocation.selector = selector;
    return invocation;
}

- (void)vm_settingSel:(NSArray *)elements
              context:(__weak NSObject * _Nullable)context {
    NSAssert(NO, @"Check!");
}

- (void)vm_insertionSel:(NSArray *)elements
                context:(__weak NSObject * _Nullable)context
                indexes:(NSMutableArray<__kindof NSNumber *> *)indexes {
    NSAssert(NO, @"Check!");
}

- (void)vm_removalSel:(NSArray *)elements
              context:(__weak NSObject * _Nullable)context
              indexes:(NSMutableArray<__kindof NSNumber *> *)indexes {
    NSAssert(NO, @"Check!");
}

- (void)vm_replacementSel:(NSArray *)elements
                  context:(__weak NSObject * _Nullable)context
                  indexes:(NSMutableArray<__kindof NSNumber *> *)indexes {
    NSAssert(NO, @"Check!");
}

@end
