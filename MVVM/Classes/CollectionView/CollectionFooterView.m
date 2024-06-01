//
//  CollectionFooterView.m
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionFooterView.h"

@implementation CollectionFooterView

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(SectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
