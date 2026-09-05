//
//  HGViewModels.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <ViewModel/BaseViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModels : BaseViewModel

@property (strong, nonatomic, nonnull, readonly) id viewModels;
@property (assign, nonatomic, readonly) NSUInteger count;

- (instancetype)initWithViewModels:(NSArray * _Nullable)viewModels;

- (id)firstViewModel;
- (id)lastViewModel;
- (void)addViewModel:(id _Nonnull)viewModel;
- (void)insertViewModel:(id _Nonnull)viewModel atIndex:(NSUInteger)index;
- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(id _Nonnull)viewModel;
- (void)replaceViewModelsAtIndexes:(NSIndexSet *)indexes withViewModels:(NSArray * _Nonnull)viewModels;
- (void)insertViewModels:(NSArray * _Nonnull)viewModels toIndexes:(NSIndexSet *)indexes;
- (void)removeViewModel:(id _Nonnull)viewModel;
- (void)removeViewModelsAtIndexes:(NSIndexSet * _Nonnull)indexes;
- (void)removeViewModels:(NSArray * _Nonnull)viewModels;
- (void)removeAllViewModels;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (NSUInteger)indexOfViewModel:(id _Nonnull)viewModel;

- (void)enumerateViewModelsUsingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block;
- (void)enumerateViewModelsWithOptions:(NSEnumerationOptions)options
                            usingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block;
- (void)enumerateViewModelsAtIndexes:(NSIndexSet *)indexes
                             options:(NSEnumerationOptions)options
                          usingBlock:(void (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))block;

- (NSUInteger)indexOfViewModelPassingTest:(BOOL (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))predicate;
- (NSUInteger)indexOfViewModelWithOptions:(NSEnumerationOptions)options
                              passingTest:(BOOL (NS_NOESCAPE ^)(id viewModel, NSUInteger index, BOOL *stop))predicate;

@end

NS_ASSUME_NONNULL_END
