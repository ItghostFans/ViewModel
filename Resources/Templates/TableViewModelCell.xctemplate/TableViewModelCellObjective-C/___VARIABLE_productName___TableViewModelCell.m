//___FILEHEADER___

#import "___VARIABLE_productName___TableViewModelCell.h"
#import "___VARIABLE_productName___TableCellViewModel.h"

@interface ___VARIABLE_productName___TableViewModelCell ()
// TODO: 添加需要的View，建议使用懒加载
@end

@implementation ___VARIABLE_productName___TableViewModelCell
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmismatched-parameter-types"
- (instancetype)initWithStyle:(VMTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
#pragma clang diagnostic ignored "-Wenum-conversion"
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
#pragma clang diagnostic pop
        self.contentView.backgroundColor = [VMColor colorWithRed:((self.hash & 0x00FF0000) >> 16) / 255.0f
                                                           green:((self.hash & 0x0000FF00) >> 8)  / 255.0f
                                                            blue:((self.hash & 0x000000FF) >> 0)  / 255.0f
                                                           alpha:1.0f];
    }
    return self;
}

- (void)setViewModel:(___VARIABLE_productName___TableCellViewModel *)viewModel {
    BOOL same = self.viewModel == viewModel;
    [super setViewModel:viewModel];
    if (same) {
        // 防止这里不必要的UI刷新。
        return;
    }
}

#pragma mark - Public

#pragma mark - Actions

#pragma mark - Private

#pragma mark - Getter

// TODO: 添加需要的View，建议使用懒加载

#pragma mark - TableViewModelCell

+ (CGFloat)heightForWidth:(CGFloat)width viewModel:(___VARIABLE_productName___TableCellViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return 0.0f;
}

@end
