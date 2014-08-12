//
//  OECardView.m
//  Or Else
//
//  Created by Tosin Afolabi on 03/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "OECardView.h"

BOOL isShowingFrontView;

@interface OECardView ()

@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;

@end

@implementation OECardView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        self.frontView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
        [[self.frontView layer] setBorderWidth:2.0];
        [[self.frontView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [self setupFrontView];

        self.backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
        [[self.backView layer] setBorderWidth:2.0];
        [[self.backView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [self setupBackView];

        [self addSubview:self.frontView];

        isShowingFrontView = true;

        // Tap Gesture On View

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];

        [self addGestureRecognizer:tap];
        [self setUserInteractionEnabled:true];

    }

    return self;
}

- (void)setupFrontView {

    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 180, 80)];
    [firstLabel setText:@"YOU NEED TO"];
    [firstLabel setFont:[UIFont fontWithName:@"Campton-Light" size:33.0]];
    [firstLabel setTextColor:[UIColor whiteColor]];
    [firstLabel setNumberOfLines:2];

    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 160, 80)];
    [secondLabel setText:@"GO TO THE GYM"];
    [secondLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:30.0]];
    [secondLabel setTextColor:[UIColor whiteColor]];
    [secondLabel setNumberOfLines:2];

    UILabel *byLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 40, 30)];
    [byLabel setText:@"by"];
    [byLabel setFont:[UIFont fontWithName:@"Campton-Light" size:30.0]];
    [byLabel setTextColor:[UIColor whiteColor]];

    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 170, 160, 30)];
    [thirdLabel setText:@"tonight"];
    [thirdLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:30.0]];
    [thirdLabel setTextColor:[UIColor whiteColor]];


    UIImage *image = [UIImage imageNamed:@"HanSolo"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(15, 230, 50, 50)];

    NSString *introString = @"I hope you can convince Han Solo that you did it";

    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithString:introString];

    NSString *boldText = @"Han Solo";
    NSRange boldTextRange = [introString rangeOfString:boldText];

    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Campton-Light" size:15.0] range:NSMakeRange(0, [introString length])];

    [mutableAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [introString length])];

    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Campton-Bold" size:15.0] range:boldTextRange];


    UILabel *fourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 235, 180, 40)];
    [fourthLabel setAttributedText:mutableAttrString];
    [fourthLabel setNumberOfLines:2];

    [self.frontView addSubview:firstLabel];
    [self.frontView addSubview:secondLabel];
    [self.frontView addSubview:thirdLabel];
    [self.frontView addSubview:byLabel];
    [self.frontView addSubview:imageView];
    [self.frontView addSubview:fourthLabel];

}

- (void)setupBackView
{
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 180, 80)];
    [firstLabel setText:@"Back View"];
    [firstLabel setFont:[UIFont fontWithName:@"Campton-Light" size:30.0]];
    [firstLabel setTextColor:[UIColor whiteColor]];
    [firstLabel setNumberOfLines:2];

    [self.backView addSubview:firstLabel];
}

- (void)viewTapped
{
    if (isShowingFrontView) {
        // transistion to back

        [UIView transitionFromView:self.frontView toView:self.backView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
        isShowingFrontView = false;
    } else {
        [UIView transitionFromView:self.backView toView:self.frontView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
        isShowingFrontView = true;
    }
}

@end
