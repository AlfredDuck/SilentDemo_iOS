//
//  ZZZURLManager.m
//  Silent
//
//  Created by alfred on 14-10-21.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZURLManager.h"

@implementation ZZZURLManager

+ (NSString *)getHomePath
{
   return @"http://silentfriend.duapp.com";
   //return @"http://127.0.0.1:18080";
}

+ (NSString *)getLoginPath
{
   return @"/login";
}

+ (NSString *)getSignupPath
{
   return @"/signup";
}

+ (NSString *)getSendMessagePath
{
   return @"/send_message";
}

+ (NSString *)getPullMessagePath
{
   return @"/get_message";
}

+ (NSString *)getSendEmailPath
{
   return @"/send_email";
}

+ (NSString *)getLogoutPath
{
   return @"/logout";
}

+ (NSString *)getUpdateTokenPath
{
   return @"/update_token";
}

@end
