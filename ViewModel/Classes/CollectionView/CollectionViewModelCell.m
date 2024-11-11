//
//  CollectionViewModelCell.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionViewModelCell.h"

@implementation CollectionViewModelCell

- (void)setViewModel:(CellViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadIndexPath];
}

#pragma mark - Subclass

- (void)reloadIndexPath {
}

+ (CGSize)cellSizeForSize:(CGSize)size viewModel:(CellViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
