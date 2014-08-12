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

@interface OEHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation OEHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {

    [super viewDidLoad];

    UIColor *backgroundColor = [UIColor colorWithRed:0.404 green:0.000 blue:0.000 alpha:1];
    [self.view setBackgroundColor:backgroundColor];

    OEHeaderView *headerView = [[OEHeaderView alloc] initWithFrame:CGRectMake(0, 10, 320, 100)];
    [self.view addSubview:headerView];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, 320, 300)];
    [scrollView setDelegate:self];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake(3 * 320, 300)];

    for (int i = 0; i < 3; i++) {

        OECardView *cardView = [[OECardView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 300)];
        [scrollView addSubview:cardView];
    }

    [self.view addSubview:scrollView];
    self.scrollView = scrollView;


    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(155, 450,10,10);
    self.pageControl.numberOfPages = 3;
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

@end