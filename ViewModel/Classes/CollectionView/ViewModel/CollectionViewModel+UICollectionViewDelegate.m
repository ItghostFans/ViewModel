//
//  CollectionViewModel+UICollectionViewDelegate.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+UICollectionViewDelegate.h"

#import <ViewModel/CellViewModel+CollectionView.h>
#import <ViewModel/CollectionViewModelCell.h>
#import <ViewModel/CollectionHeaderView.h>
#import <ViewModel/CollectionFooterView.h>

@implementation CollectionViewModel (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.item];
    ((CollectionViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ((CollectionViewModelCell *)cell).viewModel = nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((CollectionHeaderView *)view).viewModel = sectionViewModel;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        ((CollectionFooterView *)view).viewModel = sectionViewModel;
        return;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((CollectionHeaderView *)view).viewModel = nil;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        ((CollectionFooterView *)view).viewModel = nil;
        return;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    if (cellViewModel.deselectAfterDidSelect) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
