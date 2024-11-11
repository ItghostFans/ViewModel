//
//  CollectionFooterView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionFooterView.h"
#import "SectionViewModel+CollectionView.h"

@implementation CollectionFooterView

- (void)setViewModel:(SectionViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadIndexPath];
}

#pragma mark - Subclass

- (void)reloadIndexPath {
}

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(SectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
