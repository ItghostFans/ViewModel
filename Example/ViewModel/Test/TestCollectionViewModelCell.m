//
//  TestCollectionViewModelCell.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 fanchunxing1. All rights reserved.
//

#import "TestCollectionViewModelCell.h"
#import "TestCollectionCellViewModel.h"
#import "CellViewModel+CollectionView.h"
#import "SectionViewModel+CollectionView.h"

#import <Masonry/Masonry.h>

@interface TestCollectionViewModelCell ()
@property (weak, nonatomic) UILabel *indexPathLabel;
@end

@implementation TestCollectionViewModelCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
//                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
//                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
//                                               alpha:1.0f];
        self.backgroundColor = UIColor.greenColor;
    }
    return self;
}

- (void)setViewModel:(TestCollectionCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    [self reloadIndexPath];
    NSLog(@"%@", self.viewModel.thisName);
}

- (void)reloadIndexPath {
    self.indexPathLabel.text = [NSString stringWithFormat:@"%@.%@", @(self.viewModel.collectionIndexPath.section), @(self.viewModel.collectionIndexPath.item)];
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
        _indexPathLabel.font = [UIFont systemFontOfSize:6.0f];
        _indexPathLabel.textAlignment = NSTextAlignmentCenter;
        [_indexPathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _indexPathLabel;
}

#pragma mark - CollectionViewModelCell

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(TestCollectionCellViewModel *)viewModel {
    return CGSizeZero;
//    return CGSizeMake(30.0f, 30.0f);
}

@end
