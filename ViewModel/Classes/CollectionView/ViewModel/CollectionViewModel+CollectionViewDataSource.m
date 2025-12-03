//
//  CollectionViewModel+CollectionViewDataSource.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+CollectionViewDataSource.h"

#import <VMOS/VMKit.h>
#import <ViewModel/CellViewModel+CollectionView.h>

@implementation CollectionViewModel (CollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(id)collectionView {
    return self.sectionViewModels.count;
}

- (NSInteger)collectionView:(id)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sectionViewModels[section] count];
}
#if TARGET_OS_IPHONE
- (VMCollectionViewCell *)collectionView:(id)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (VMCollectionViewCell *)collectionView:(id)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
#endif // #if TARGET_OS_IPHONE
{
    CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellViewModel.collectionCellClass) forIndexPath:indexPath];
}

- (VMCollectionReusableView *)collectionView:(id)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
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

@end
