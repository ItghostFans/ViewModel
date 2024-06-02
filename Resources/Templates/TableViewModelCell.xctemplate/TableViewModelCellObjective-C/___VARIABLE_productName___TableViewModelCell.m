//___FILEHEADER___

#import "___VARIABLE_productName___TableViewModelCell.h"
#import "___VARIABLE_productName___TableCellViewModel.h"

#import <Masonry/Masonry.h>

@interface ___VARIABLE_productName___TableViewModelCell ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___TableViewModelCell

@synthesize viewModel = _viewModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - TableViewModelCell

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(___VARIABLE_productName___TableCellViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return 0.0f;
}

@end
