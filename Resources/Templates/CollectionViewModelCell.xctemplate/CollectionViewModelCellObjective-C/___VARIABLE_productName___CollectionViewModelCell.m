//___FILEHEADER___

#import "___VARIABLE_productName___CollectionViewModelCell.h"
#import "___VARIABLE_productName___CollectionCellViewModel.h"

#import <Masonry/Masonry.h>

@interface ___VARIABLE_productName___CollectionViewModelCell ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___CollectionViewModelCell

@synthesize viewModel = _viewModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                               green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                               alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(___VARIABLE_productName___CollectionCellViewModel *)viewModel {
    [super setViewModel:viewModel];
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - CollectionViewModelCell

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(___VARIABLE_productName___CollectionCellViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
