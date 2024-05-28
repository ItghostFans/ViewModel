//
//  BaseViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IBaseViewModelDelegate <NSObject>
@end

@interface BaseViewModel : NSObject

@property (weak, nonatomic, nullable) id<IBaseViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
