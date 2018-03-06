//
//  RYAlertController.h
//  Expecta
//
//  Created by Readygo X on 2018/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface RYAlertController : UIViewController <UIViewControllerTransitioningDelegate>

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

@end



typedef NS_ENUM(NSUInteger, RYAlertAnimationType) {
    RYAlertAnimationTypePresent = 0,
    RYAlertAnimationTypeDismiss
};

@interface RYAlertControllerAnimationTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(RYAlertAnimationType)type;

- (instancetype)initWithType:(RYAlertAnimationType)type;

@end

NS_ASSUME_NONNULL_END
