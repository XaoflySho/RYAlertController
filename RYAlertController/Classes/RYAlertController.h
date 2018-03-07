//
//  RYAlertController.h
//  Expecta
//
//  Created by Readygo X on 2018/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RYAlertActionStyle) {
    RYAlertActionStyleDefault = 0,
    RYAlertActionStyleCancel,
    RYAlertActionStyleDestructive,
};

@interface RYAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(RYAlertActionStyle)style handler:(void (^ __nullable)(RYAlertAction *action))handler;
+ (instancetype)subactionWithTitle:(nullable NSString *)title image:(UIImage *)image handler:(void (^ __nullable)(RYAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) RYAlertActionStyle style;

@end

@interface RYAlertActionButton : UIButton

@property (nullable, nonatomic, readonly) RYAlertAction *action;
+ (instancetype)buttonWithAction:(RYAlertAction *)action;

@end

@interface RYAlertSubactionView : UIView

@property (nullable, nonatomic, readonly) RYAlertAction *action;
@property (nullable, nonatomic, readonly) RYAlertActionButton *button;
+ (instancetype)viewWithAction:(RYAlertAction *)action;

@end

@interface RYAlertController : UIViewController <UIViewControllerTransitioningDelegate>

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addAction:(RYAlertAction *)action;
@property (nonatomic, readonly) NSArray<RYAlertAction *> *actions;

- (void)addSubaction:(RYAlertAction *)action;
@property (nonatomic, readonly) NSArray<RYAlertAction *> *subactions;

@property (nullable, nonatomic, copy) NSString *message;

@end

typedef NS_ENUM(NSUInteger, RYInterfaceActionItemSeparatorViewStyle) {
    RYInterfaceActionItemSeparatorViewStyleHorizontal = 0,
    RYInterfaceActionItemSeparatorViewStyleVertical
};

@interface RYInterfaceActionItemSeparatorView : UIView

@property (nonatomic, assign) RYInterfaceActionItemSeparatorViewStyle style;

+ (instancetype)separatorViewWithStyle:(RYInterfaceActionItemSeparatorViewStyle)style;

@end

typedef NS_ENUM(NSUInteger, RYAlertAnimationType) {
    RYAlertAnimationTypePresent = 0,
    RYAlertAnimationTypeDismiss
};

@interface RYAlertControllerAnimationTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(RYAlertAnimationType)type;

@end

NS_ASSUME_NONNULL_END
