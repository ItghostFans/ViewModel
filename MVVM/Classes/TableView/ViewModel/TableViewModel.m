//
//  TableViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "CellViewModel+TableView.h"
#import "TableViewModelCell.h"
#import "TableHeaderView.h"
#import "TableFooterView.h"

@interface CellViewModel ()
@property (weak, nonatomic) NSIndexPath *tableIndexPath;
@end

@interface TableViewModel () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic) NSMutableSet *registeredHeaderFooterIdentifiers;

@end

@implementation TableViewModel

- (instancetype)init {
    if (self = [super init]) {
        _sectionViewModels = [[BaseViewModels alloc] initWithViewModels:@[]];
        _registeredCellIdentifiers = NSMutableSet.new;
        _registeredHeaderFooterIdentifiers = NSMutableSet.new;
    }
    return self;
}

- (void)dealloc {
}

- (void)setTableView:(UITableView *)tableView {
    @weakify(self);
    [[[_sectionViewModels rac_valuesAndChangesForKeyPath:@keypath(_sectionViewModels.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:_sectionViewModels.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self);
        [self onSectionsChange:change object:self.sectionViewModels observer:self];
    }];
    
    [_registeredCellIdentifiers removeAllObjects];
    [_registeredHeaderFooterIdentifiers removeAllObjects];
    _tableView = tableView;
    
    for (SectionViewModel *sectionViewModel in _sectionViewModels.viewModels) {
        [self registerHeaderFooterClass:sectionViewModel.tableHeaderClass];
        [self registerHeaderFooterClass:sectionViewModel.tableFooterClass];
        for (CellViewModel *cellViewModel in sectionViewModel.viewModels) {
            [self registerCellClass:cellViewModel.tableCellClass];
        }
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)setDelegate:(id<ITableViewModelDelegate>)delegate {
    [super setDelegate:delegate];
}

- (id<ITableViewModelDelegate>)delegate {
    return (id<ITableViewModelDelegate>)super.delegate;
}

#pragma mark - KVO Handler

- (void)addKvoSectionViewModel:(BaseViewModels *)viewModel {
    @weakify(self, viewModel);
    [[[viewModel rac_valuesAndChangesForKeyPath:@keypath(viewModel.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:viewModel.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self, viewModel);
        [self onRowsChange:change object:viewModel observer:self];
    }];
}

#pragma mark - KVO

- (void)onSectionsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    [self.tableView beginUpdates];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.tableView deleteSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        default: {
            break;
        }
    }
    [self.tableView endUpdates];
}

- (void)onRowsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    NSMutableArray<__kindof NSIndexPath *> *indexPathes = NSMutableArray.new;
    NSInteger section = [_sectionViewModels.viewModels indexOfObject:object];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPathes addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
    }];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.tableCellClass];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.tableCellClass];
            }
            [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.tableView deleteRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeReplacement: {
            [self.tableView reloadRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - Private

- (void)registerCellClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (![_registeredCellIdentifiers containsObject:identifier]) {
        [self.tableView registerClass:class forCellReuseIdentifier:identifier];
        [_registeredCellIdentifiers addObject:identifier];
    }
}

- (void)registerHeaderFooterClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredHeaderFooterIdentifiers containsObject:identifier]) {
        [self.tableView registerClass:class forHeaderFooterViewReuseIdentifier:identifier];
        [_registeredHeaderFooterIdentifiers addObject:identifier];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionViewModels[indexPath.section][indexPath.row] tableCellHeightForWidth:CGRectGetWidth(tableView.frame)];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    cellViewModel.tableIndexPath = indexPath;
    ((TableViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    if ([cellViewModel.delegate respondsToSelector:@selector(didSelectedViewModel:atIndexPath:)]) {
        [cellViewModel.delegate didSelectedViewModel:cellViewModel atIndexPath:indexPath];
    }
    if (cellViewModel.deselectAfterDidSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

/// mark - Header

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableHeaderClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableHeaderClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableHeaderHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableHeaderView *)view).viewModel = sectionViewModel;
}

/// mark - Footer

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    if (sectionViewModel.tableFooterClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionViewModel.tableFooterClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel tableFooterHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    ((TableFooterView *)view).viewModel = sectionViewModel;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionViewModels.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellViewModel.tableCellClass) forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionViewModels[section] viewModels].count;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

@end
