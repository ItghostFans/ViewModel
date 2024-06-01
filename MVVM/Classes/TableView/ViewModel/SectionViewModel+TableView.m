//
//  SectionViewModel+TableView.m
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "SectionViewModel+TableView.h"

#import <objc/runtime.h>

#import "TableHeaderView.h"
#import "TableFooterView.h"

@interface SectionViewModel ()

@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *headerWidthHeights;
@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *footerWidthHeights;

@end

@implementation SectionViewModel (TableView)

- (NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *)headerWidthHeights {
    NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *headerWidthHeights = objc_getAssociatedObject(self, @selector(headerWidthHeights));
    if (!headerWidthHeights) {
        headerWidthHeights = NSMutableDictionary.new;
        objc_setAssociatedObject(self, @selector(headerWidthHeights), headerWidthHeights, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return headerWidthHeights;
}

- (NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *)footerWidthHeights {
    NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *footerWidthHeights = objc_getAssociatedObject(self, @selector(footerWidthHeights));
    if (!footerWidthHeights) {
        footerWidthHeights = NSMutableDictionary.new;
        objc_setAssociatedObject(self, @selector(footerWidthHeights), footerWidthHeights, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return footerWidthHeights;
}

#pragma mark - ITableSectionViewModel

- (NSInteger)tableSection {
    return [objc_getAssociatedObject(self, @selector(tableSection)) integerValue];
}

- (void)setTableSection:(NSInteger)tableSection {
    objc_setAssociatedObject(self, @selector(tableSection), @(tableSection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)tableHeaderClass {
//    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return TableHeaderView.class;
}

- (Class)tableFooterClass {
//    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return TableFooterView.class;
}

- (CGFloat)tableHeaderHeightForWidth:(CGFloat)width {
    NSNumber *height;
    @synchronized (self.headerWidthHeights) {
        height = self.headerWidthHeights[@(width)];
        if (!height) {
            CGFloat contentWidth = width;
            CGFloat headerHeight = [self.tableHeaderClass heightForWidth:&contentWidth viewModel:self];
            height = @(headerHeight > 0.0f ? headerHeight : 0.0f);
            self.headerWidthHeights[@(width)] = height;
        }
    }
    
    return height.doubleValue;
}

- (CGFloat)tableFooterHeightForWidth:(CGFloat)width {
    NSNumber *height;
    @synchronized (self.footerWidthHeights) {
        height = self.footerWidthHeights[@(width)];
        if (!height) {
            CGFloat contentWidth = width;
            CGFloat footerHeight = [self.tableFooterClass heightForWidth:&contentWidth viewModel:self];
            height = @(footerHeight > 0.0f ? footerHeight : 0.0f);
            self.footerWidthHeights[@(width)] = height;
        }
    }
    
    return height.doubleValue;
}

@end
