//
//  TableViewModelCell.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableViewModelCell.h"

@implementation TableViewModelCell

- (void)setViewModel:(CellViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadIndexPath];
}

#pragma mark - Subclass

- (void)reloadIndexPath {
}

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(CellViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return 0.0f;
}

@end
