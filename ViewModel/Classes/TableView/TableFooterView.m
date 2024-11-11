//
//  TableFooterView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableFooterView.h"
#import "SectionViewModel+TableView.h"

@implementation TableFooterView

- (void)setViewModel:(SectionViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadIndexPath];
}

#pragma mark - Subclass

- (void)reloadIndexPath {
}

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(SectionViewModel *)viewModel {
    return 0.0f;
}

@end
