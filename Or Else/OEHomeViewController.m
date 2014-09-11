//
//  OEHomeViewController.m
//  Or Else
//
//  Created by Tosin Afolabi on 02/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "OECardView.h"
#import "OEHeaderView.h"
#import "OESubmitView.h"
#import "OEHomeViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "OEPlaceholderView.h"

@interface OEHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) OEPlaceholderView *placeholder;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *myTasks;
@property (nonatomic, strong) NSArray *friendsTasks;

@end

@implementation OEHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIColor *backgroundColor = [UIColor colorWithRed:0.404 green:0.000 blue:0.000 alpha:1];
    [self.view setBackgroundColor:backgroundColor];

    OEHeaderView *headerView = [[OEHeaderView alloc] initWithFrame:CGRectMake(0, 10, 320, 100)];
    [self.view addSubview:headerView];

    self.placeholder = [[OEPlaceholderView alloc] initWithFrame:CGRectMake(0, 130, 320, 300)];
    [self.view addSubview:self.placeholder];
    
    [self fetchMyTasks];
    [self fetchFriendsTasks];
}

- (void)loadUserTasks
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, 320, 300)];
    [scrollView setDelegate:self];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake([self.myTasks count] * 320, 300)];

    for (int i = 0; i < [self.myTasks count]; i++) {
        OECardView *cardView = [[OECardView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 300)];

        PFObject *task = self.myTasks[i];

        [cardView.secondLabel setText:task[@"task"]];
        [cardView.thirdLabel setText:task[@"date"]];
        NSLog(@"%@", task[@"creatorID"] );
        
        [scrollView addSubview:cardView];
    }

    [self.placeholder removeFromSuperview];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(155, 450,10,10);
    self.pageControl.numberOfPages = [self.myTasks count];
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];

    OESubmitView *submitView = [[OESubmitView alloc] initWithFrame:CGRectMake(160, 470, 150, 90)];
    [self.view addSubview:submitView];
}

#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}

- (void)fetchMyTasks {
        PFQuery *query = [PFQuery queryWithClassName:@"Task"];
        [query whereKey:@"creatorID" equalTo:[PFUser currentUser].username];

        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.myTasks = objects;
                [self loadUserTasks];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
}

- (void)fetchFriendsTasks {
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *me, NSError *error) {

        if(error) return;
        PFQuery *query = [PFQuery queryWithClassName:@"Task"];
        [query whereKey:@"supervisorID" equalTo:me.objectID];

        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.friendsTasks = objects;
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }];
}

@end
