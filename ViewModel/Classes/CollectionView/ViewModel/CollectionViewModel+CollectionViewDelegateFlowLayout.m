//
//  CollectionViewModel+CollectionViewDelegateFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+CollectionViewDelegateFlowLayout.h"

#import <ViewModel/CellViewModel+CollectionView.h>

@implementation CollectionViewModel (CollectionViewDelegateFlowLayout)

- (CGSize)collectionView:(VMCollectionView *)collectionView layout:(VMCollectionView *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    return [cellViewModel collectionCellSizeForSize:collectionView.frame.size];
}

- (CGFloat)collectionView:(VMCollectionView *)collectionView layout:(VMCollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumInteritemSpacing;
}

- (CGFloat)collectionView:(VMCollectionView *)collectionView layout:(VMCollectionView *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return sectionViewModel.collectionMinimumLineSpacing;
}

- (CGSize)collectionView:(VMCollectionView *)collectionView layout:(VMCollectionView *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionHeaderSizeForSize:collectionView.frame.size];
}

- (CGSize)collectionView:(VMCollectionView *)collectionView layout:(VMCollectionView *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    SectionViewModel *sectionViewModel = self.sectionViewModels[section];
    return [sectionViewModel collectionFooterSizeForSize:collectionView.frame.size];
}

@end
