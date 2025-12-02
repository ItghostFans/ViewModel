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
//- (void)insertViewModels:(NSArray *)viewModels atIndexes:(NSIndexSet *)indexes;   // iOS这个地方会导致死循环
- (void)removeViewModel:(id _Nonnull)viewModel;
- (void)removeViewModelsAtIndexes:(NSIndexSet * _Nonnull)indexes;
- (void)removeViewModels:(NSArray * _Nonnull)viewModels;
- (void)removeAllViewModels;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (NSUInteger)indexOfViewModel:(id _Nonnull)viewModel;

@end

NS_ASSUME_NONNULL_END
