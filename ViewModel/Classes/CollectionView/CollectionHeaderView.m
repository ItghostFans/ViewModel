//
//  CollectionHeaderView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionHeaderView.h"
#import "SectionViewModel+CollectionView.h"

@implementation CollectionHeaderView

- (void)setViewModel:(SectionViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadIndexPath];
}

#pragma mark - Subclass

- (void)reloadIndexPath {
}

+ (CGSize)headerSizeForSize:(CGSize)size viewModel:(SectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
