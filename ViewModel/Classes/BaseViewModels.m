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
    if (self = [super init]) {
        _viewModels = viewModels.mutableCopy;
    }
    return self;
}

- (void)dealloc {
    
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

//- (void)insertViewModels:(NSArray *)viewModels atIndexes:(NSIndexSet *)indexes {
//    [[self mutableArrayValueForKey:NSStringFromSelector(@selector(viewModels))] insertObjects:viewModels atIndexes:indexes];
//}

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

@end
