//
//  FacebookHelper.m
//  Or Else
//
//  Created by Hani Kazmi on 17/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "FacebookHelper.h"
#import <Parse/Parse.h>

@implementation FacebookHelper

+ (void)authenticateWithFacebook {
    NSArray *permissionsArray = @[ @"user_about_me", @"user_friends", @"read_friendlists"];
    
    [PFFacebookUtils initializeFacebook];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        }
    }];
}

@end
