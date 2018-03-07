//
//  RYAlertController.m
//  Expecta
//
//  Created by Readygo X on 2018/3/6.
//

#import "RYAlertController.h"

@interface RYAlertAction ()

@property (nullable, nonatomic, readwrite) NSString *title;
@property (nullable, nonatomic, readwrite) UIImage *image;
@property (nonatomic, readwrite) RYAlertActionStyle style;
@property (nonatomic, readwrite) void (^handler)(RYAlertAction *);

@end

@implementation RYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(RYAlertActionStyle)style handler:(void (^)(RYAlertAction * _Nonnull))handler {
    RYAlertAction *action = [[RYAlertAction alloc]init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

+ (instancetype)subactionWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(RYAlertAction * _Nonnull))handler {
    RYAlertAction *action = [[RYAlertAction alloc]init];
    action.title = title;
    action.image = image;
    action.handler = handler;
    return action;
}

@end

@interface RYAlertActionButton ()

@property (nullable, nonatomic, readwrite) RYAlertAction *action;

@end

@implementation RYAlertActionButton

+ (instancetype)buttonWithAction:(RYAlertAction *)action {
    RYAlertActionButton *button = [RYAlertActionButton buttonWithType:UIButtonTypeSystem];
    button.action = action;
    
    [button setTitle:action.title forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    switch (action.style) {
        case RYAlertActionStyleCancel:
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            [button setTintColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]];
            break;
         case RYAlertActionStyleDefault:
            button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            [button setTintColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]];
            break;
        case RYAlertActionStyleDestructive:
            button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            [button setTintColor:[UIColor colorWithRed:1 green:0.23 blue:0.19 alpha:1]];
            break;
    }
    
    return button;
}

@end

@interface RYAlertSubactionView ()

@property (nullable, nonatomic, readwrite) RYAlertAction *action;
@property (nullable, nonatomic, readwrite) RYAlertActionButton *button;

@end

@implementation RYAlertSubactionView

+ (instancetype)viewWithAction:(RYAlertAction *)action {
    RYAlertSubactionView *view = [[RYAlertSubactionView alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:action.image];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = action.title;
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.textColor = [UIColor colorWithRed:0 green:0.48 blue:1 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    NSLayoutConstraint *imageViewCenterX = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [imageViewCenterX setActive:YES];
    
    NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    [imageViewTop setActive:YES];
    
    NSLayoutConstraint *imageViewRatio = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [imageViewRatio setActive:YES];
    
    NSLayoutConstraint *titleLabelCenterX = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:titleLabel.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [titleLabelCenterX setActive:YES];
    
    NSLayoutConstraint *titleLabelTop = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLastBaseline relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:22];
    [titleLabelTop setActive:YES];
    
    NSLayoutConstraint *titleLabelWidth = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:titleLabel.superview attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [titleLabelWidth setActive:YES];
    
    NSLayoutConstraint *titleLabelBottom = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLastBaseline relatedBy:NSLayoutRelationEqual toItem:titleLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-24];
    [titleLabelBottom setActive:YES];
    
    RYAlertActionButton *button = [RYAlertActionButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.action = action;
    [view addSubview:button];
    
    NSLayoutConstraint *buttonTop = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [buttonTop setActive:YES];
    
    NSLayoutConstraint *buttonLeft = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [buttonLeft setActive:YES];
    
    NSLayoutConstraint *buttonBottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [buttonBottom setActive:YES];
    
    NSLayoutConstraint *buttonRight = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [buttonRight setActive:YES];
    
    view.button = button;
    
    return view;
}

@end

@interface RYAlertController () 

@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

@property (nonatomic, weak) IBOutlet UIView *foreView;
@property (nonatomic, weak) IBOutlet UIScrollView *headerScrollView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *headerScrollViewBottom;

@property (nonatomic, weak) IBOutlet UIView *subactionSequenceView;
@property (nonatomic, weak) IBOutlet UIStackView *subactionStackView;

@property (nonatomic, weak) IBOutlet UIView *actionSequenceView;
@property (nonatomic, weak) IBOutlet UIStackView *actionStackView;

@property (nonatomic, strong) NSMutableArray<RYAlertAction *> *actionArray;
@property (nonatomic, strong) RYAlertAction *cancelAction;

@property (nonatomic, strong) NSMutableArray<RYAlertAction *> *subactionArray;

@end

@implementation RYAlertController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self classForCoder]];
    RYAlertController *alertController = [[RYAlertController alloc]initWithNibName:NSStringFromClass([self class]) bundle:bundle];
    alertController.title = title;
    alertController.message = message;
    
    return alertController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.actionArray = [[NSMutableArray alloc]init];
        self.subactionArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = self.title;
    self.messageLabel.text = self.message;
    
    [self loadAction];
    [self loadSubaction];
}

- (void)loadAction {
    NSUInteger actionsCount = self.actionArray.count;
    __block RYAlertActionButton *cancelButton;
    if (self.cancelAction) {
        actionsCount++;
        
        cancelButton = [RYAlertActionButton buttonWithAction:self.cancelAction];
        [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionStackView addArrangedSubview:cancelButton];
        
        NSLayoutConstraint *cancelButtonHeight = [NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44];
        [cancelButtonHeight setActive:YES];
    }
    
    if (actionsCount) {
        [self.actionSequenceView setHidden:NO];
        
        if (actionsCount <= 2) {
            self.actionStackView.axis = UILayoutConstraintAxisHorizontal;
            
            [self.actionArray enumerateObjectsUsingBlock:^(RYAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                RYInterfaceActionItemSeparatorView *separatorView = [RYInterfaceActionItemSeparatorView separatorViewWithStyle:RYInterfaceActionItemSeparatorViewStyleVertical];
                separatorView.translatesAutoresizingMaskIntoConstraints = NO;
                [self.actionStackView addArrangedSubview:separatorView];
                
                RYAlertActionButton *button = [RYAlertActionButton buttonWithAction:obj];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.actionStackView addArrangedSubview:button];
                
                if (!cancelButton) {
                    cancelButton = button;
                }
                
                NSLayoutConstraint *buttonHeight = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44];
                [buttonHeight setActive:YES];
                
                NSLayoutConstraint *buttonWidht = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cancelButton attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
                [buttonWidht setActive:YES];
                
            }];
            
        } else {
            self.actionStackView.axis = UILayoutConstraintAxisVertical;
            
            [self.actionArray enumerateObjectsUsingBlock:^(RYAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RYAlertActionButton *button = [RYAlertActionButton buttonWithAction:obj];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.actionStackView addArrangedSubview:button];
                
                NSLayoutConstraint *buttonHeight = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44];
                [buttonHeight setActive:YES];
                
                RYInterfaceActionItemSeparatorView *separatorView = [RYInterfaceActionItemSeparatorView separatorViewWithStyle:RYInterfaceActionItemSeparatorViewStyleHorizontal];
                separatorView.translatesAutoresizingMaskIntoConstraints = NO;
                [self.actionStackView addArrangedSubview:separatorView];
                
            }];
            
            [self.actionStackView insertArrangedSubview:cancelButton atIndex:self.actionStackView.arrangedSubviews.count - 1];
        }
        

        
    } else {
        [self.actionSequenceView setHidden:YES];
    }

}

- (void)buttonClick:(RYAlertActionButton *)sender {
    if (sender.action.handler) {
        sender.action.handler(sender.action);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadSubaction {
    if (self.subactionArray.count) {
        [self.subactionSequenceView setHidden:NO];
        
        __block RYAlertSubactionView *firstView;
        
        [self.subactionArray enumerateObjectsUsingBlock:^(RYAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            RYAlertSubactionView *view = [RYAlertSubactionView viewWithAction:obj];
            [view.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.subactionStackView addArrangedSubview:view];
            
            if (!firstView) {
                firstView = view;
            }
            
//            NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:64];
//            [viewHeight setActive:YES];
            
            NSLayoutConstraint *viewWidht = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            [viewWidht setActive:YES];
        }];
        
    } else {
        [self.subactionSequenceView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAction:(RYAlertAction *)action {
    if (action.style == RYAlertActionStyleCancel) {
        self.cancelAction = action;
    } else {
        [self.actionArray addObject:action];
    }
}

- (void)addSubaction:(RYAlertAction *)action {
    
    [self.subactionArray addObject:action];
}

- (NSArray <RYAlertAction *> *)actions {
    return [NSArray arrayWithArray:self.actionArray];
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


@interface RYInterfaceActionItemSeparatorView ()

@property (nonatomic, strong) NSLayoutConstraint *height;
@property (nonatomic, strong) NSLayoutConstraint *width;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *foreView;

@end

@implementation RYInterfaceActionItemSeparatorView

+ (instancetype)separatorViewWithStyle:(RYInterfaceActionItemSeparatorViewStyle)style {
    RYInterfaceActionItemSeparatorView *separatorView = [[RYInterfaceActionItemSeparatorView alloc]initWithStyle:style];
    
    return separatorView;
}

- (instancetype)initWithStyle:(RYInterfaceActionItemSeparatorViewStyle)style {
    self = [super init];
    if (self) {
        [self addLayoutConstraint];
        self.style = style;
        [self viewInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self initWithStyle:self.style];
    }
    return self;
}

- (void)addLayoutConstraint {
    CGFloat constant = 1 / [[UIScreen mainScreen] scale];
    self.height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    self.width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
}

- (void)viewInit {
    self.backgroundColor = nil;
    
    self.backView = [[UIView alloc]initWithFrame:self.bounds];
    self.backView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.backView];
    
    self.foreView = [[UIView alloc]initWithFrame:self.bounds];
    self.foreView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.31 alpha:0.05];
    self.foreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.foreView];
}

- (void)setStyle:(RYInterfaceActionItemSeparatorViewStyle)style {
    switch (style) {
        case RYInterfaceActionItemSeparatorViewStyleHorizontal:
            [self.width setActive:NO];
            [self.height setActive:YES];
            break;
        
        case RYInterfaceActionItemSeparatorViewStyleVertical:
            [self.height setActive:NO];
            [self.width setActive:YES];
            break;
    }
    self.backView.frame = self.bounds;
    self.foreView.frame = self.bounds;
}

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
            return 0.15;
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
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *backView = [[UIView alloc]initWithFrame:containerView.bounds];
    backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [containerView addSubview:backView];
    
    [self addUserInteractionViewToContainerView:containerView];
    
//    [containerView addSubview:toViewController.view];
    [self addToViewControllerView:toViewController.view containerView:containerView];
    
    toViewController.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
    toViewController.view.alpha = 0;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
                         toViewController.view.transform = CGAffineTransformIdentity;
                         toViewController.view.alpha = 1;
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
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
//                         fromViewController.view.alpha = 0;
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

