//
//  BaseViewModels.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModels.h"

@interface BaseViewModels ()
@property (strong, nonatomic) NSMutableArray *viewModels;
@end

@implementation BaseViewModels

- (instancetype)init {
    if (self = [super init]) {
        _viewModels = NSMutableArray.new;
    }
    return self;
}

- (instancetype)initWithViewModels:(NSArray *)viewModels {
    if (viewModels) {
        self = [super init];
        _viewModels = viewModels.mutableCopy;
    } else {
        self = [self init];
    }
    return self;
}

- (void)dealloc {
}

- (NSUInteger)count {
    return _viewModels.count;
}

- (id)firstViewModel {
    return _viewModels.firstObject;
}

- (id)lastViewModel {
    return _viewModels.lastObject;
}

- (void)addViewModel:(id)viewModel {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] addObject:viewModel];
}

- (void)insertViewModel:(id)viewModel atIndex:(NSUInteger)index {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] insertObject:viewModel atIndex:index];
}

- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(id)viewModel {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] replaceObjectAtIndex:index withObject:viewModel];
}

- (void)replaceViewModelsAtIndexes:(NSIndexSet *)indexes withViewModels:(NSArray * _Nonnull)viewModels {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] replaceObjectsAtIndexes:indexes withObjects:viewModels];
}

- (void)insertViewModels:(NSArray *)viewModels toIndexes:(NSIndexSet *)indexes {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] insertObjects:viewModels atIndexes:indexes];
}

- (void)removeViewModel:(id)viewModel {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] removeObject:viewModel];
}

- (void)removeViewModelsAtIndexes:(NSIndexSet *)indexes {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] removeObjectsAtIndexes:indexes];
}

- (void)removeViewModels:(NSArray *)viewModels {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] removeObjectsInArray:viewModels];
}

- (void)removeAllViewModels {
    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] removeAllObjects];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.viewModels objectAtIndex:idx];
}

- (NSUInteger)indexOfViewModel:(id)viewModel {
    return [self.viewModels indexOfObject:viewModel];
}

- (void)enumerateViewModelsUsingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block {
    [self.viewModels enumerateObjectsUsingBlock:block];
}

- (void)enumerateViewModelsWithOptions:(NSEnumerationOptions)options
                            usingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block {
    [self.viewModels enumerateObjectsWithOptions:options
                                      usingBlock:block];
}

- (void)enumerateViewModelsAtIndexes:(NSIndexSet *)indexes
                             options:(NSEnumerationOptions)options
                          usingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block {
    [self.viewModels enumerateObjectsAtIndexes:indexes
                                       options:options
                                    usingBlock:block];
}

- (NSUInteger)indexOfViewModelPassingTest:(BOOL (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))predicate {
    return [self.viewModels indexOfObjectPassingTest:predicate];
}

- (NSUInteger)indexOfViewModelWithOptions:(NSEnumerationOptions)options
                              passingTest:(BOOL (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))predicate {
    return [self.viewModels indexOfObjectWithOptions:options
                                         passingTest:predicate];
}

@end
