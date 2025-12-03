//
//  CollectionViewModel+CollectionViewDelegateFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+CollectionViewDelegateFlowLayout.h"

#import <ViewModel/CellViewModel+CollectionView.h>

@implementation CollectionViewModel (UICollectionViewDelegateFlowLayout)

- (CGSize)collectionView:(id)collectionView layout:(id)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    return [cellViewModel collectionCellSizeForSize:[collectionView frame].size];
}

- (CGFloat)collectionView:(id)collectionView layout:(id)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumInteritemSpacing;
}

- (CGFloat)collectionView:(id)collectionView layout:(id)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumLineSpacing;
}

- (CGSize)collectionView:(id)collectionView layout:(id)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionHeaderSizeForSize:[collectionView frame].size];
}

- (CGSize)collectionView:(id)collectionView layout:(id)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionFooterSizeForSize:[collectionView frame].size];
}

@end
