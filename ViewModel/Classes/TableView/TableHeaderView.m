//
//  TableHeaderView.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableHeaderView.h"

#import <ViewModel/SectionViewModel+TableView.h>

@implementation TableHeaderView

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
