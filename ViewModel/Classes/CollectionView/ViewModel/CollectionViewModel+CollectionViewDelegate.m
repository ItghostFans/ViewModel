//
//  CollectionViewModel+UICollectionViewDelegate.m
//  ViewModel
//
//  Created by ItghostFan on 2024/5/31.
//

#import "CollectionViewModel+CollectionViewDelegate.h"

#import <VMOS/VMKit.h>
#import <ViewModel/CellViewModel+CollectionView.h>
#import <ViewModel/CollectionViewModelCell.h>
#import <ViewModel/CollectionHeaderView.h>
#import <ViewModel/CollectionFooterView.h>

@implementation CollectionViewModel (UICollectionViewDelegate)

#if TARGET_OS_IPHONE
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(VMCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(VMCollectionViewCell *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
#endif // #if TARGET_OS_IPHONE
{
    SectionViewModel *sectionViewModel = self.sectionViewModels[indexPath.section];
    CellViewModel *cellViewModel = sectionViewModel[indexPath.item];
    ((CollectionViewModelCell *)cell).viewModel = cellViewModel;
}

#if TARGET_OS_IPHONE
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
#endif // #if TARGET_OS_IPHONE
{
    ((CollectionViewModelCell *)cell).viewModel = nil;
}

#if TARGET_OS_IPHONE
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (void)collectionView:(NSCollectionView *)collectionView willDisplaySupplementaryView:(NSView *)view forElementKind:(NSCollectionViewSupplementaryElementKind)elementKind atIndexPath:(NSIndexPath *)indexPath
#endif // #if TARGET_OS_IPHONE
{
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

#if TARGET_OS_IPHONE
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (void)collectionView:(NSCollectionView *)collectionView didEndDisplayingSupplementaryView:(NSView *)view forElementOfKind:(NSCollectionViewSupplementaryElementKind)elementKind atIndexPath:(NSIndexPath *)indexPath
#endif // #if TARGET_OS_IPHONE
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((CollectionHeaderView *)view).viewModel = nil;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        ((CollectionFooterView *)view).viewModel = nil;
        return;
    }
}

#if TARGET_OS_IPHONE
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
#elif TARGET_OS_MAC
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
#endif // #if TARGET_OS_IPHONE
{
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
    for (NSIndexPath *indexPath in indexPaths) {
#endif // #if TARGET_OS_IPHONE
        CellViewModel *cellViewModel = self.sectionViewModels[indexPath.section][indexPath.item];
        if (cellViewModel.deselectAfterDidSelect) {
            [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
    }
#endif // #if TARGET_OS_IPHONE
}

@end
