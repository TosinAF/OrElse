//
//  OENewTaskViewController.m
//  Or Else
//
//  Created by Tosin Afolabi on 03/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import <MMPickerView.h>
#import "OENewTaskViewController.h"

@interface OENewTaskViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *deadlineOptions;
@property (nonatomic, strong) UILabel *deadlineLabel;
@property (nonatomic, strong) UITextField *taskTextField;

@end

@implementation OENewTaskViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.taskTextField becomeFirstResponder];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.404 green:0.000 blue:0.000 alpha:1]];

    self.deadlineOptions = @[@"tonight", @"tomorrow morning", @"this afternoon"];

    UIColor *whiteColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
    [titleLabel setText:@"Create A New Task"];
    [titleLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:25.0]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:whiteColor];

    UILabel *firstLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 50, 30)];
    [firstLine setText:@"YO,"];
    [firstLine setTextColor:whiteColor];
    [firstLine setFont:[UIFont fontWithName:@"Campton-Bold" size:30.0]];

    UILabel *secondLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 260, 30)];
    [secondLine setText:@"I need to"];
    [secondLine setTextColor:whiteColor];
    [secondLine setFont:[UIFont fontWithName:@"Campton" size:24.0]];

    UITextField *taskTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 190, 260, 30)];
    [taskTextField setPlaceholder:@"do some laundry"];
    [taskTextField setFont:[UIFont fontWithName:@"Campton-Bold" size:24.0]];
    [taskTextField setTextColor:whiteColor];
    [taskTextField setDelegate:self];
    [taskTextField becomeFirstResponder];
    [taskTextField setReturnKeyType:UIReturnKeyNext];
    [taskTextField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [taskTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];

    taskTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"do some laundry" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];

    UILabel *byLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 30, 30)];
    [byLabel setText:@"by"];
    [byLabel setTextColor:whiteColor];
    [byLabel setFont:[UIFont fontWithName:@"Campton" size:24.0]];

    UILabel *deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 230, 220, 30)];
    [deadlineLabel setText:@"tonight"];
    [deadlineLabel setTextColor:whiteColor];
    [deadlineLabel setFont:[UIFont fontWithName:@"Campton-Bold" size:24.0]];


    self.taskTextField = taskTextField;
    self.deadlineLabel = deadlineLabel;

    [self.view addSubview:titleLabel];
    [self.view addSubview:firstLine];
    [self.view addSubview:secondLine];
    [self.view addSubview:taskTextField];
    [self.view addSubview:byLabel];
    [self.view addSubview:deadlineLabel];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];

    NSDictionary *options = @{MMtextColor: [UIColor whiteColor],
                              MMbackgroundColor: [UIColor colorWithRed:0.404 green:0.000 blue:0.000 alpha:1],
                              MMbuttonColor: [UIColor colorWithRed:0.404 green:0.000 blue:0.000 alpha:1],
                              MMfont: [UIFont fontWithName:@"Campton-Bold" size:25.0]
                              };

    [MMPickerView showPickerViewInView:self.view
                           withStrings:self.deadlineOptions
                           withOptions:options
                            completion:^(NSString *selectedString) {
                                //selectedString is the return value which you can use as you wish
                                self.deadlineLabel.text = selectedString;
                            }];

    [MMPickerView onDoneButtonPressed:^{
        NSLog(@"Push New View");
    }];

    return NO;
}

@end