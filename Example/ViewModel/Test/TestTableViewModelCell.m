//
//  TestTableViewModelCell.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestTableViewModelCell.h"
#import "TestTableCellViewModel.h"

#import <Masonry/Masonry.h>

@interface TestTableViewModelCell ()
@property (weak, nonatomic) UILabel *indexPathLabel;
@end

@implementation TestTableViewModelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                               alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(TestTableCellViewModel *)viewModel {
    BOOL same = self.viewModel == viewModel;
    [super setViewModel:viewModel];
    if (same) {
        // 防止这里不必要的UI刷新。
        return;
    }
}

- (void)reloadIndexPath {
    self.indexPathLabel.text = [NSString stringWithFormat:@"%@.%@", @(self.viewModel.tableIndexPath.section), @(self.viewModel.tableIndexPath.item)];
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

- (UILabel *)indexPathLabel {
    if (!_indexPathLabel) {
        UILabel *indexPathLabel = UILabel.new;
        _indexPathLabel = indexPathLabel;
        [self.contentView addSubview:_indexPathLabel];
        _indexPathLabel.textColor = UIColor.redColor;
        _indexPathLabel.font = [UIFont systemFontOfSize:15.0f];
        _indexPathLabel.textAlignment = NSTextAlignmentCenter;
        [_indexPathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _indexPathLabel;
}

#pragma mark - TableViewModelCell

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TestTableCellViewModel *)viewModel {
    return 30.0f;
}

@end
