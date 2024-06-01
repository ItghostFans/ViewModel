//
//  CollectionHeaderView.m
//  MVVM
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

+ (CGSize)headerSizeForSize:(CGSize *)size viewModel:(SectionViewModel *)viewModel {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CGSizeZero;
}

@end
