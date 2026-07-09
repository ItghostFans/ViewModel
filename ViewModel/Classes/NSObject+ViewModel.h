//
//  NSObject+ViewModel.h
//  Pods
//
//  Created by ItghostFan on 2026/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RACDisposable;

@interface NSObject (ViewModel)

- (RACDisposable *)vm_arrayChangesForKeyPath:(NSString *)keyPath
                                      object:(NSObject *)object
                                    observer:(__weak NSObject *)observer
                                     context:(__weak NSObject * _Nullable)context
                                  settingSel:(SEL)settingSel
                                insertionSel:(SEL)insertionSel
                                  removalSel:(SEL)removalSel
                              replacementSel:(SEL)replacementSel;

- (void)vm_settingSel:(NSArray *)elements
              context:(__weak NSObject * _Nullable)context NS_UNAVAILABLE;

- (void)vm_insertionSel:(NSArray *)elements
                context:(__weak NSObject * _Nullable)context
                indexes:(NSMutableArray<__kindof NSNumber *> *)indexes NS_UNAVAILABLE;

- (void)vm_removalSel:(NSArray *)elements
              context:(__weak NSObject * _Nullable)context
              indexes:(NSMutableArray<__kindof NSNumber *> *)indexes NS_UNAVAILABLE;

- (void)vm_replacementSel:(NSArray *)elements
                  context:(__weak NSObject * _Nullable)context
                  indexes:(NSMutableArray<__kindof NSNumber *> *)indexes NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
