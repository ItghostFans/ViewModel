//
//  HGViewModels.h
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import <Foundation/Foundation.h>

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModels : BaseViewModel

@property (strong, nonatomic, nonnull, readonly) NSArray *viewModels;

- (instancetype)initWithViewModels:(NSArray *)viewModels;

- (void)addViewModel:(id)viewModel;
- (void)insertViewModel:(id)viewModel atIndex:(NSUInteger)index;
- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(id)viewModel;
//- (void)insertViewModels:(NSArray *)viewModels atIndexes:(NSIndexSet *)indexes;   // iOS这个地方会导致死循环
- (void)removeViewModel:(id)viewModel;
- (void)removeViewModelsAtIndexes:(NSIndexSet *)indexes;
- (void)removeViewModels:(NSArray *)viewModels;
- (void)removeAllViewModels;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
