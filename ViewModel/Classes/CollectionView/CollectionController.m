//
//  CollectionController.m
//  ViewModel
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionController.h"

#import "CollectionViewModel.h"
#import "CollectionControllerViewModel.h"

@interface CollectionController ()

@property (weak, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setter

- (void)setViewModel:(CollectionControllerViewModel *)viewModel {
    _viewModel = viewModel;
}

#pragma mark - Getter

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout) {
        return _flowLayout;
    }
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    _flowLayout = flowLayout;
    _flowLayout.minimumLineSpacing = 0.0f;
    _flowLayout.itemSize = CGSizeMake(1.0f, 1.0f);
    _flowLayout.minimumInteritemSpacing = 5.0f;
    _flowLayout.minimumLineSpacing = 5.0f;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    _collectionView = collectionView;
    _collectionView.backgroundColor = UIColor.clearColor;
    return collectionView;
}

#pragma mark - Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.viewModel.collectionViewModel respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [self.viewModel.collectionViewModel.class instanceMethodSignatureForSelector:aSelector];
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.viewModel.collectionViewModel];
}

@end
