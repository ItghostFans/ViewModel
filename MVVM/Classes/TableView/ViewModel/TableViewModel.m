//
//  TableViewModel.m
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableViewModel.h"
#import "TableViewModel+UITableViewDelegate.h"
#import "TableViewModel+UITableViewDataSource.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "CellViewModel+TableView.h"
#import "SectionViewModel+TableView.h"

@interface TableViewModel ()

@property (strong, nonatomic) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic) NSMutableSet *registeredHeaderFooterIdentifiers;

@end

@implementation TableViewModel

@synthesize delegate = _delegate;

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
    if (!_tableView.delegate) {
        _tableView.delegate = self;
    }
    if (!_tableView.dataSource) {
        _tableView.dataSource = self;
    }
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
            for (SectionViewModel *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
                sectionViewModel.tableViewModel = self;
            }
            [self.tableView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (SectionViewModel *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
                sectionViewModel.tableViewModel = self;
            }
            [self.tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                SectionViewModel *sectionViewModel = self.sectionViewModels[idx];
                sectionViewModel.tableViewModel = nil;
            }];
            [self.tableView deleteSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeReplacement: {
//            for (SectionViewModel *sectionViewModel in news) {
//                [self addKvoSectionViewModel:sectionViewModel];
//                sectionViewModel.tableViewModel = self;
//            }
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
                cellViewModel.tableSectionViewModel = _sectionViewModels[section];
            }
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (CellViewModel *cellViewModel in news) {
                [self registerCellClass:cellViewModel.tableCellClass];
                cellViewModel.tableSectionViewModel = _sectionViewModels[section];
            }
            [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            for (NSIndexPath *indexPath in indexPathes) {
                CellViewModel *cellViewModel = _sectionViewModels[indexPath.section][indexPath.row];
                cellViewModel.tableSectionViewModel = nil;
            }
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

@end
