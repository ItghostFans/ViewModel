//
//  CollectionController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionController.h"

#import "CollectionViewModel.h"
#import "CollectionControllerViewModel.h"

@interface CollectionController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setter

- (void)setViewModel:(CollectionControllerViewModel *)viewModel {
    _viewModel = viewModel;
    _viewModel.collectionViewModel.collectionView = self.collectionView;
}

#pragma mark - Getter

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = UICollectionViewFlowLayout.new;
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.itemSize = CGSizeMake(1.0f, 1.0f);
        _flowLayout.minimumInteritemSpacing = 5.0f;
        _flowLayout.minimumLineSpacing = 5.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = UIColor.clearColor;
    }
    return _collectionView;
}

@end
