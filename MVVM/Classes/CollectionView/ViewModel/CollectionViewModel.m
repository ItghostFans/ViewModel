//
//  CollectionViewModel.m
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionViewModel.h"
#import "CollectionViewModel+UICollectionViewDelegate.h"
#import "CollectionViewModel+UICollectionViewDataSource.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "CellViewModel+CollectionView.h"
#import "SectionViewModel+CollectionView.h"

@interface CollectionViewModel ()

@property (strong, nonatomic, nonnull) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic, nonnull) NSMutableSet *registeredHeaderIdentifiers;
@property (strong, nonatomic, nonnull) NSMutableSet *registeredFooterIdentifiers;

@property (strong, nonatomic, nullable) RACCompoundDisposable *disposableBag;

@end

@implementation CollectionViewModel

- (instancetype)init {
    if (self = [super init]) {
        _sectionViewModels = [[BaseViewModels alloc] initWithViewModels:@[]];
        _registeredCellIdentifiers = NSMutableSet.new;
        _registeredHeaderIdentifiers = NSMutableSet.new;
        _registeredFooterIdentifiers = NSMutableSet.new;
    }
    return self;
}

- (void)dealloc {
}

- (void)setDelegate:(id<ICollectionViewModelDelegate>)delegate {
    [super setDelegate:delegate];
}

- (id<ICollectionViewModelDelegate>)delegate {
    return (id<ICollectionViewModelDelegate>)super.delegate;
}

#pragma mark - Private

- (void)registerCellClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredCellIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forCellWithReuseIdentifier:identifier];
        [_registeredCellIdentifiers addObject:identifier];
    }
}

- (void)registerHeaderClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredHeaderIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        [_registeredHeaderIdentifiers addObject:identifier];
    }
}

- (void)registerFooterClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredFooterIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
        [_registeredFooterIdentifiers addObject:identifier];
    }
}

#pragma mark - Setter

- (void)setCollectionView:(UICollectionView *)collectionView {
    @weakify(self);
    if (_disposableBag) {
        [_disposableBag dispose];
    }
    if (collectionView) {
        _disposableBag = RACCompoundDisposable.new;
        [_disposableBag addDisposable:
         [[[_sectionViewModels rac_valuesAndChangesForKeyPath:@keypath(_sectionViewModels.viewModels)
                                                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                                     observer:self] takeUntil:_sectionViewModels.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
            RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
            @strongify(self);
            [self onSectionsChange:change object:self.sectionViewModels observer:self];
        }]];
    }
    
    [_registeredCellIdentifiers removeAllObjects];
    [_registeredHeaderIdentifiers removeAllObjects];
    [_registeredFooterIdentifiers removeAllObjects];
    _collectionView = collectionView;
    
    for (SectionViewModel *sectionViewModel in _sectionViewModels.viewModels) {
        [self registerHeaderClass:sectionViewModel.collectionHeaderClass];
        [self registerFooterClass:sectionViewModel.collectionFooterClass];
        for (CellViewModel *cellViewModel in sectionViewModel.viewModels) {
            [self registerCellClass:cellViewModel.collectionCellClass];
        }
    }
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark - KVO Handler

- (void)addKvoSectionViewModel:(BaseViewModels *)viewModel {
    @weakify(self, viewModel);
    [[[viewModel rac_valuesAndChangesForKeyPath:@keypath(viewModel.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:viewModel.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self, viewModel);
        [self onItemsChange:change object:viewModel observer:self];
    }];
}

#pragma mark - KVO

- (void)onSectionsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (SectionViewModel *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
                sectionViewModel.collectionViewModel = self;
            }
            [self.collectionView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (SectionViewModel *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
                sectionViewModel.collectionViewModel = self;
            }
            [self.collectionView insertSections:indexes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                SectionViewModel *sectionViewModel = self.sectionViewModels[idx];
                sectionViewModel.collectionViewModel = nil;
            }];
            [self.collectionView deleteSections:indexes];
            break;
        }
        case NSKeyValueChangeReplacement: {
//            for (SectionViewModel *sectionViewModel in news) {
//                [self addKvoSectionViewModel:sectionViewModel];
//                sectionViewModel.collectionViewModel = self;
//            }
            [self.collectionView reloadSections:indexes];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)onItemsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    NSMutableArray<__kindof NSIndexPath *> *indexPathes = NSMutableArray.new;
    NSInteger section = [self.sectionViewModels.viewModels indexOfObject:object];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPathes addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
    }];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.collectionCellClass];
                cellViewModel.collectionSectionViewModel = _sectionViewModels[section];
            }
//            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.collectionCellClass];
                cellViewModel.collectionSectionViewModel = _sectionViewModels[section];
            }
            [self.collectionView insertItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            for (NSIndexPath *indexPath in indexPathes) {
                CellViewModel *cellViewModel = _sectionViewModels[indexPath.section][indexPath.row];
                cellViewModel.collectionSectionViewModel = nil;
            }
            [self.collectionView deleteItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeReplacement: {
            [self.collectionView reloadItemsAtIndexPaths:indexPathes];
            break;
        }
        default: {
            break;
        }
    }
}

@end
