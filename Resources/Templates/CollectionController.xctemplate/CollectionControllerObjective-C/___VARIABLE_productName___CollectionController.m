//___FILEHEADER___

#import "___VARIABLE_productName___CollectionController.h"
#import "___VARIABLE_productName___CollectionControllerViewModel.h"
#import <ViewModel/CollectionViewModel.h>

@interface ___VARIABLE_productName___CollectionController ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    self.viewModel.collectionViewModel.collectionView = self.collectionView;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

@end
