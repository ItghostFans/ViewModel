//
//  TableHeaderView.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SectionViewModel;

@interface TableHeaderView : VMTableViewHeaderFooterView

@property (weak, nonatomic, nullable) SectionViewModel *viewModel;

#pragma mark - Subclass

- (void)reloadIndexPath;

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(SectionViewModel * _Nonnull)viewModel;

@end

NS_ASSUME_NONNULL_END
