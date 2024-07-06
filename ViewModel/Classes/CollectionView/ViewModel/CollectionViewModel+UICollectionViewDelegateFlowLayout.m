//
//  CollectionViewModel+UICollectionViewDelegateFlowLayout.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+UICollectionViewDelegateFlowLayout.h"

#import "CellViewModel+CollectionView.h"

@implementation CollectionViewModel (UICollectionViewDelegateFlowLayout)

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

@end
