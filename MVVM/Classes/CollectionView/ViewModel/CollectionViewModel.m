//
//  CollectionViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "CellViewModel+CollectionView.h"
#import "CollectionViewModelCell.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

@interface CollectionViewModel () <
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (strong, nonatomic, nonnull) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic, nonnull) NSMutableSet *registeredHeaderIdentifiers;
@property (strong, nonatomic, nonnull) NSMutableSet *registeredFooterIdentifiers;

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
    [[[_sectionViewModels rac_valuesAndChangesForKeyPath:@keypath(_sectionViewModels.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:_sectionViewModels.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self);
        [self onSectionsChange:change object:self.sectionViewModels observer:self];
    }];
    
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
        [self onCellsChange:change object:viewModel observer:self];
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
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
//            [self.collectionView insertSections:indexes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.collectionView deleteSections:indexes];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadSections:indexes];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)onCellsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
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
            }
            [self.collectionView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.collectionCellClass];
            }
            [self.collectionView insertItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.collectionView deleteItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadItemsAtIndexPaths:indexPathes];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    return [cellViewModel collectionCellSizeForSize:collectionView.frame.size];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumLineSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionHeaderSizeForSize:collectionView.frame.size];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionFooterSizeForSize:collectionView.frame.size];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionViewModels.viewModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sectionViewModels[section] viewModels].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellViewModel.collectionCellClass) forIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(sectionViewModel.collectionHeaderClass) forIndexPath:indexPath];
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(sectionViewModel.collectionFooterClass) forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    cellViewModel.collectionIndexPath = indexPath;
    ((CollectionViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    sectionViewModel.collectionIndexPath = indexPath;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((CollectionHeaderView *)view).viewModel = sectionViewModel;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((CollectionFooterView *)view).viewModel = sectionViewModel;
        return;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    if ([cellViewModel.delegate respondsToSelector:@selector(didSelectedViewModel:atIndexPath:)]) {
        [cellViewModel.delegate didSelectedViewModel:cellViewModel atIndexPath:indexPath];
    }
    if (cellViewModel.deselectAfterDidSelect) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
