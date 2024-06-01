//
//  CollectionViewModel+UICollectionViewDelegate.m
//  MVVM
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+UICollectionViewDelegate.h"

#import "CellViewModel+CollectionView.h"
#import "CollectionViewModelCell.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

@implementation CollectionViewModel (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.item];
    cellViewModel.collectionSectionViewModel = sectionViewModel;
    ((CollectionViewModelCell *)cell).viewModel = cellViewModel;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        sectionViewModel.collectionViewModel = self;
        ((CollectionHeaderView *)view).viewModel = sectionViewModel;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        sectionViewModel.collectionViewModel = self;
        ((CollectionFooterView *)view).viewModel = sectionViewModel;
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
