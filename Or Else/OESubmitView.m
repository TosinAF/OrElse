//
//  OESubmitView.m
//  Or Else
//
//  Created by Tosin Afolabi on 09/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "OESubmitView.h"

@implementation OESubmitView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 20, 60, 40)];
        [label setText:@"I DID IT,"];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:@"Campton-Bold" size:15.0]];
        [label setNumberOfLines:2];

        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 85, 40)];
        [label2 setText:@"I PROMISE!"];
        [label2 setTextAlignment:NSTextAlignmentRight];
        [label2 setTextColor:[UIColor whiteColor]];
        [label2 setFont:[UIFont fontWithName:@"Campton-Bold" size:15.0]];
        [label2 setNumberOfLines:2];

        UIImage *image = [UIImage imageNamed:@"CompleteButton"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(90, 25, 50, 50)];

        [self addSubview:label];
        [self addSubview:label2];
        [self addSubview:imageView];
    }

    return self;
}


@end
