//
//  ZZZURLManager.h
//  Silent
//
//  Created by alfred on 14-10-21.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZZURLManager : NSObject
@property (nonatomic, strong) NSString *homePath;
@property (nonatomic, strong) NSString *loginPath;
@property (nonatomic, strong) NSString *signupPath;
@property (nonatomic, strong) NSString *sendMessagePath;
@property (nonatomic, strong) NSString *pullMessagePath;
+ (NSString *)getHomePath;
+ (NSString *)getLoginPath;
+ (NSString *)getSignupPath;
+ (NSString *)getSendMessagePath;
+ (NSString *)getPullMessagePath;
+ (NSString *)getSendEmailPath;
+ (NSString *)getLogoutPath;
+ (NSString *)getUpdateTokenPath;
@end
