
//  FacebookHelper.h
//  Or Else
//
//  Created by Hani Kazmi on 17/08/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookHelper : NSObject

+(void)authenticateWithFacebook;
+(void)createFacebookPostWithText:(NSString *)text;

@end