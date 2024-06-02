//___FILEHEADER___

#import "___VARIABLE_productName___TableFooterView.h"
#import "___VARIABLE_productName___SectionViewModel.h"

#import <Masonry/Masonry.h>

@interface ___VARIABLE_productName___TableFooterView ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___TableFooterView

@synthesize viewModel = _viewModel;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - TableFooterView

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(___VARIABLE_productName___SectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return 0.0f;
}

@end
