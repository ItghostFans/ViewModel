//
//  TableFooterView.h
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SectionViewModel;

@interface TableFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic, nullable) SectionViewModel *viewModel;

#pragma mark - Subclass

- (void)reloadIndexPath;

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(SectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
