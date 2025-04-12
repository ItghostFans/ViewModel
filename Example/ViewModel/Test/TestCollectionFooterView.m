//
//  TestCollectionFooterView.m
//  ViewModel_Example
//
//  Created by ItghostFan on 2024/7/4.
//  Copyright © 2024 ItghostFans. All rights reserved.
//

#import "TestCollectionFooterView.h"
#import "TestSectionViewModel.h"
#import "SectionViewModel+CollectionView.h"
#import "CollectionViewModel.h"

#import <Masonry/Masonry.h>

@interface TestCollectionFooterView ()
@property (weak, nonatomic) UILabel *indexPathLabel;
@end

@implementation TestCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                               alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(TestSectionViewModel *)viewModel {
    BOOL same = self.viewModel == viewModel;
    [super setViewModel:viewModel];
    if (same) {
        // 防止这里不必要的UI刷新。
        return;
    }
}

- (void)reloadIndexPath {
    self.indexPathLabel.text = [NSString stringWithFormat:@"%@", @(self.viewModel.collectionSectionIndex)];
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

- (UILabel *)indexPathLabel {
    if (!_indexPathLabel) {
        UILabel *indexPathLabel = UILabel.new;
        _indexPathLabel = indexPathLabel;
        [self addSubview:_indexPathLabel];
        _indexPathLabel.textColor = UIColor.redColor;
        _indexPathLabel.font = [UIFont systemFontOfSize:15.0f];
        _indexPathLabel.textAlignment = NSTextAlignmentCenter;
        [_indexPathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _indexPathLabel;
}

#pragma mark - CollectionFooterView

+ (CGSize)footerSizeForSize:(CGSize)size viewModel:(TestSectionViewModel *)viewModel {
    if ([viewModel.collectionViewModel.collectionView.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)viewModel.collectionViewModel.collectionView.collectionViewLayout;
        switch (flowLayout.scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                return CGSizeMake(size.height, 20.0f);
            }
            case UICollectionViewScrollDirectionHorizontal: {
                return CGSizeMake(20.0f, size.width);
            }
            default: {
                break;
            }
        }
    }
    return CGSizeMake(20.0f, size.width);
}

@end
