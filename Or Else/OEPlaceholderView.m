//
//  OEPlaceholderView.m
//  Or Else
//
//  Created by Tosin Afolabi on 19/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "OEPlaceholderView.h"

@implementation OEPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
        //[[view layer] setBorderWidth:2.0];
        //[[view layer] setBorderColor:[[UIColor whiteColor] CGColor]];

        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 90)];
        [firstLabel setText:@"Loading..."];
        [firstLabel setTextAlignment:NSTextAlignmentCenter];
        [firstLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:40.0]];
        [firstLabel setTextColor:[UIColor whiteColor]];
        [firstLabel setNumberOfLines:2];

        [view addSubview:firstLabel];
        [self addSubview:view];
    }
    
    return self;
}


@end
