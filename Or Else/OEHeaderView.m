//
//  OEHeaderView.m
//  Or Else
//
//  Created by Tosin Afolabi on 03/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import <POP/POP.h>
#import "OEHeaderView.h"

bool onTasks;
CGRect tasksLineFrame;
CGRect friendsTasksLineFrame;

@interface OEHeaderView ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *tasksLabel;
@property (nonatomic, strong) UILabel *friendsTasksLabel;

@end

@implementation OEHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        onTasks = true;
        CGRect tasksLineFrame = CGRectMake(20, 70, 70, 3);
        CGRect friendsTasksLineFrame = CGRectMake(118, 70, 180, 3);

        UILabel *tasksLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 100, 30)];
        [tasksLabel setText:@"TASKS"];
        [tasksLabel setTextColor:[UIColor whiteColor]];
        [tasksLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:22.0]];

        UITapGestureRecognizer *tapOnTasks = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tasksPressed)];
        [tasksLabel addGestureRecognizer:tapOnTasks];
        [tasksLabel setUserInteractionEnabled:YES];

        self.tasksLabel = tasksLabel;

        //[tasksLabel setAlpha:0.6];

        UILabel *friendsTasksLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 200, 30)];
        [friendsTasksLabel setText:@"FRIENDS' TASKS"];
        [friendsTasksLabel setTextColor:[UIColor whiteColor]];
        [friendsTasksLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:22.0]];

        UITapGestureRecognizer *tapOnFriendsTasks = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendsTasksPressed)];
        [friendsTasksLabel addGestureRecognizer:tapOnFriendsTasks];
        [friendsTasksLabel setUserInteractionEnabled:YES];

        self.friendsTasksLabel = friendsTasksLabel;

        self.line = [[UIView alloc] initWithFrame:tasksLineFrame];
        [self.line setBackgroundColor:[UIColor whiteColor]];

        [self addSubview:tasksLabel];
        [self addSubview:friendsTasksLabel];
        [self addSubview:self.line];

    }

    return self;
}

- (void)tasksPressed
{

    if (!onTasks) {

        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        anim.springBounciness = 5;
        anim.springSpeed = 3;
        anim.toValue = @(55.0);
        [self.line.layer pop_addAnimation:anim forKey:@"posx"];

        POPBasicAnimation *anim3 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim3.toValue = @(0.6);
        [self.friendsTasksLabel pop_addAnimation:anim3 forKey:@"alpha"];

        POPBasicAnimation *anim2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
        //anim2.fromValue = [NSValue valueWithCGSize:tasksLineFrame.size];
        anim2.toValue = [NSValue valueWithCGSize:CGSizeMake(80, 3)];
        [self.line pop_addAnimation:anim2 forKey:@"size"];

        POPBasicAnimation *anim4 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim4.toValue = @(1.0);
        [self.tasksLabel pop_addAnimation:anim4 forKey:@"alpha"];

        onTasks = true;

    }
}

- (void)friendsTasksPressed
{

    if (onTasks) {

        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        anim.springBounciness = 5;
        anim.springSpeed = 3;
        anim.toValue = @(208.0);
        [self.line.layer pop_addAnimation:anim forKey:@"posx"];

        POPBasicAnimation *anim2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
        //anim2.fromValue = [NSValue valueWithCGSize:tasksLineFrame.size];
        anim2.toValue = [NSValue valueWithCGSize:CGSizeMake(185, 3)];
        [self.line pop_addAnimation:anim2 forKey:@"size"];

        POPBasicAnimation *anim3 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim3.toValue = @(0.6);
        [self.tasksLabel pop_addAnimation:anim3 forKey:@"alpha"];

        POPBasicAnimation *anim4 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim4.toValue = @(1.0);
        [self.friendsTasksLabel pop_addAnimation:anim4 forKey:@"alpha"];
        
        onTasks = false;
        
    }
}



@end
