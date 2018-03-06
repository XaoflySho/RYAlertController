//
//  RYAlertController.m
//  Expecta
//
//  Created by Readygo X on 2018/3/6.
//

#import "RYAlertController.h"

@interface RYAlertController () 

@property (nonatomic, strong) IBOutlet UIView *contentView;

@end

@implementation RYAlertController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self classForCoder]];
    RYAlertController *alertController = [[RYAlertController alloc]initWithNibName:NSStringFromClass([self class]) bundle:bundle];
//    alertController.transitioningDelegate = alertController;
//    alertController.modalPresentationStyle = UIModalPresentationCustom;
//    alert.titleText = title;
//    alert.descriptionText = description;
//    alert.cancelText = cancel ? cancel : @"取消";
//    alert.buttonText = button;
//    alert.buttonAction = buttonAction;
    
    return alertController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
//        self.view.bounds = CGRectMake(0, 0, 270, 150);
//        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self contentViewInit];
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    UIBlurEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:visualEffect];
//    visualEffectView.frame = self.view.bounds;
//    [self.view addSubview:visualEffectView];
////    self.view.backgroundColor = [UIColor whiteColor];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = self.view.bounds;
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    NSLog(@"animationControllerForPresentedController");
    return [RYAlertControllerAnimationTransition transitionWithType:RYAlertAnimationTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    NSLog(@"animationControllerForDismissedController");
    return [RYAlertControllerAnimationTransition transitionWithType:RYAlertAnimationTypeDismiss];
}

//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
//    NSLog(@"interactionControllerForPresentation");
//    return <#expression#>
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    NSLog(@"interactionControllerForDismissal");
//}

@end



@interface RYAlertControllerAnimationTransition ()

@property (nonatomic, assign) RYAlertAnimationType type;

@end

@implementation RYAlertControllerAnimationTransition

+ (instancetype)transitionWithType:(RYAlertAnimationType)type {
    return [[RYAlertControllerAnimationTransition alloc]initWithType:type];
}

- (instancetype)initWithType:(RYAlertAnimationType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case RYAlertAnimationTypePresent:
            return 0.3;
            break;
        case RYAlertAnimationTypeDismiss:
            return 0.1;
            break;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case RYAlertAnimationTypePresent:
            [self presentAnimationTransition:transitionContext];
            break;
            case RYAlertAnimationTypeDismiss:
            [self dismissAnimationTransition:transitionContext];
            break;
    }
}

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *backView = [[UIView alloc]initWithFrame:containerView.bounds];
    backView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [containerView addSubview:backView];
    
    [self addUserInteractionViewToContainerView:containerView];
    
//    [containerView addSubview:toViewController.view];
    [self addToViewControllerView:toViewController.view containerView:containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
                     }
                     completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)addUserInteractionViewToContainerView:(UIView *)containerView {
    UIView *userInteractionView = [[UIView alloc]initWithFrame:containerView.bounds];
    userInteractionView.translatesAutoresizingMaskIntoConstraints = NO;
    userInteractionView.userInteractionEnabled = NO;
    [containerView addSubview:userInteractionView];
    
    NSLayoutConstraint *userInteractionViewWidth = [NSLayoutConstraint constraintWithItem:userInteractionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:userInteractionView.superview attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [userInteractionViewWidth setActive:YES];
    
    NSLayoutConstraint *userInteractionViewTop = [NSLayoutConstraint constraintWithItem:userInteractionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userInteractionView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [userInteractionViewTop setActive:YES];
    
    NSLayoutConstraint *userInteractionViewLeft = [NSLayoutConstraint constraintWithItem:userInteractionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:userInteractionView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [userInteractionViewLeft setActive:YES];
    
    NSLayoutConstraint *userInteractionViewBottom = [NSLayoutConstraint constraintWithItem:userInteractionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:userInteractionView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [userInteractionViewBottom setActive:YES];
}

- (void)addToViewControllerView:(UIView *)view containerView:(UIView *)containerView {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:view];
    
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:8];
    [viewTop setActive:YES];

    NSLayoutConstraint *viewBottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8];
    [viewBottom setActive:YES];

    NSLayoutConstraint *viewCenterX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [viewCenterX setActive:YES];

    NSLayoutConstraint *viewCenterY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [viewCenterY setActive:YES];
}

- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         containerView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

@end

