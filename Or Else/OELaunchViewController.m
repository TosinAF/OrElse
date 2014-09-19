//
//  OELaunchViewController.m
//  Or Else
//
//  Created by Tosin Afolabi on 02/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import <Parse/Parse.h>
#import <POP/POP.h>
#import "OELaunchViewController.h"
#import "OENewTaskViewController.h"
#import "JCRBlurView.h"
#import "FacebookHelper.h"

BOOL firstClick;

@interface OELaunchViewController ()

@property (strong, nonatomic) UILabel *text;
@property (strong, nonatomic) UIButton *btn;

@property (strong, nonatomic) UIImageView *pointOne;
@property (strong, nonatomic) UIImageView *pointTwo;
@property (strong, nonatomic) UIImageView *pointThree;

@property (strong, nonatomic) UILabel *stepsLabel;
@property (strong, nonatomic) UILabel *stepOneLabel;
@property (strong, nonatomic) UILabel *stepTwoLabel;
@property (strong, nonatomic) UILabel *stepThreeLabel;

@end

@implementation OELaunchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setTitle:@"hello"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    firstClick = true;

    [self addBackground];
    [self addIntroText];
    [self addButton];
    [self prepareViewsToBeFadedIn];
}

- (void)buttonClicked
{
    if (firstClick) {

        [self.btn setTitle:@"Login with Facebook!" forState:UIControlStateNormal];

        CGRect pointOneFrame = CGRectMake(20, 105, 40, 40);
        CGRect pointTwoFrame = CGRectMake(20, 200, 40, 40);
        CGRect pointThreeFrame = CGRectMake(20, 300, 40, 40);

        CGRect stepsLabelFrame = CGRectMake(20, 25, 250, 50);
        CGRect stepOneFrame = CGRectMake(70, 100, 250, 50);
        CGRect stepTwoFrame = CGRectMake(70, 200, 220, 50);
        CGRect stepThreeFrame = CGRectMake(70, 280, 220, 150);

        POPBasicAnimation *anim3 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim3.fromValue = @(1.0);
        anim3.toValue = @(0.0);

        [self.text pop_addAnimation:anim3 forKey:@"alpha"];
        [self.text removeFromSuperview];

        [self.view addSubview:self.stepsLabel];
        [self.view addSubview:self.stepOneLabel];
        [self.view addSubview:self.stepTwoLabel];
        [self.view addSubview:self.stepThreeLabel];
        [self.view addSubview:self.pointOne];
        [self.view addSubview:self.pointTwo];
        [self.view addSubview:self.pointThree];

        [self addFrameAnimationToView:self.stepsLabel forPosition:stepsLabelFrame];
        [self addFrameAnimationToView:self.stepOneLabel forPosition:stepOneFrame];
        [self addFrameAnimationToView:self.pointOne forPosition:pointOneFrame];
        [self addFrameAnimationToView:self.stepTwoLabel forPosition:stepTwoFrame];
        [self addFrameAnimationToView:self.pointTwo forPosition:pointTwoFrame];
        [self addFrameAnimationToView:self.stepThreeLabel forPosition:stepThreeFrame];
        [self addFrameAnimationToView:self.pointThree forPosition:pointThreeFrame];

        firstClick = false;

    } else {
//        if ([PFUser currentUser] && // Check if user is cached
//            [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) { // Check if user is linked to Facebook
//            // Present the next view controller without animation
//            [self.navigationController pushViewController:[OENewTaskViewController new] animated:YES];
//        } else {
            [FacebookHelper authenticateWithFacebook];
//        }
        [self.navigationController pushViewController:[OENewTaskViewController new] animated:YES];
    }
}

#pragma mark - Utility Methods

- (void)addBackground
{
    UIImage *backgroundImage = [UIImage imageNamed:@"LaunchBackground"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [imageView setFrame:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];

    JCRBlurView *blurView = [JCRBlurView new];
    [blurView setFrame:CGRectMake(0,0,320,self.view.frame.size.height)];
    [blurView setAlpha:0.7];
    [blurView setBlurTintColor:[UIColor colorWithRed:0.796 green:0.298 blue:0.169 alpha:1]];

    [self.view addSubview:imageView];
    [self.view addSubview:blurView];
}

- (void)addIntroText
{
    NSString *introString = @"Having the motivation to get stuff done has never been easier!";

    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithString:introString];

    NSString *boldText = @"motivation";
    NSRange boldTextRange = [introString rangeOfString:boldText];

    [mutableAttrString addAttributes:@{
                                       NSFontAttributeName : [UIFont fontWithName:@"Campton-Light" size:30.0],
                                       NSForegroundColorAttributeName : [UIColor whiteColor]
                                       }
                               range:NSMakeRange(0, [introString length])];
    
    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Campton-Bold" size:35.0]
                              range:boldTextRange];

    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 250, 300)];
    [text setAttributedText:mutableAttrString];
    [text setNumberOfLines:0];
    [text setTextColor:[UIColor whiteColor]];

    self.text = text;
    [self.view addSubview:self.text];
}

- (void)addButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 100, 320, 100)];
    [btn setBackgroundColor:[UIColor whiteColor]];

    [btn setTitle:@"How?" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithRed:0.796 green:0.298 blue:0.169 alpha:1] forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont fontWithName:@"Campton-Bold" size:25.0]];

    self.btn = btn;

    [self.view addSubview:self.btn];
}

- (void)prepareViewsToBeFadedIn
{
    UIImageView *pointOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointOne"]];
    [pointOne setFrame:CGRectMake(20, 105 - 1000, 40, 40)];

    UIImageView *pointTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointTwo"]];
    [pointTwo setFrame:CGRectMake(20, 200 - 1000, 40, 40)];

    UIImageView *pointThree = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointThree"]];
    [pointThree setFrame:CGRectMake(20, 300 - 1000, 40, 40)];

    UILabel *stepsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25 - 1000, 250, 50)];
    [stepsLabel setText:@"Here's How"];
    [stepsLabel setFont:[UIFont fontWithName:@"Campton-Light" size:30.0]];
    [stepsLabel setTextColor:[UIColor whiteColor]];

    UILabel *stepOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 100 - 1000, 250, 50)];
    [stepOneLabel setText:@"You create a task"];
    [stepOneLabel setFont:[UIFont fontWithName:@"Campton-Light" size:20.0]];
    [stepOneLabel setTextColor:[UIColor whiteColor]];

    UILabel *stepTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 200 - 1000, 220, 50)];
    [stepTwoLabel setText:@"Choose a friend to make sure you do it"];
    [stepTwoLabel setFont:[UIFont fontWithName:@"Campton-Light" size:20.0]];
    [stepTwoLabel setTextColor:[UIColor whiteColor]];
    [stepTwoLabel setNumberOfLines:0];

    UILabel *stepThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 300 - 1000, 240, 200)];
    [stepThreeLabel setText:@"Finish the task OR ELSE we'll let your friend post to your facebook wall... as you. Ready?"];
    [stepThreeLabel setFont:[UIFont fontWithName:@"Campton-Light" size:20.0]];
    [stepThreeLabel setTextColor:[UIColor whiteColor]];
    [stepThreeLabel setNumberOfLines:0];

    self.pointOne = pointOne;
    self.pointTwo = pointTwo;
    self.pointThree = pointThree;
    self.stepsLabel = stepsLabel;
    self.stepOneLabel = stepOneLabel;
    self.stepTwoLabel = stepTwoLabel;
    self.stepThreeLabel = stepThreeLabel;
}

- (void)addFrameAnimationToView:(UIView *)view forPosition:(CGRect)rect
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.springBounciness = 5;
    anim.springSpeed = 3;
    anim.toValue = [NSValue valueWithCGRect:rect];
    [view pop_addAnimation:anim forKey:@"frame"];
}

@end