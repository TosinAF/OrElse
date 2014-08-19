//
//  OENotificationViewController.m
//  Or Else
//
//  Created by Tosin Afolabi on 19/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "OENotificationViewController.h"

@implementation OENotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.796 green:0.298 blue:0.169 alpha:1];


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
    [label setText:@"You have 1 Pending Sponsorship Invite"];
    [label setTextAlignment:NSTextAlignmentCenter];

    [self.view addSubview:label];


}

@end
