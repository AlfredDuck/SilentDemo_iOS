//
//  ZZZUserDefault.m
//  Silent
//
//  Created by alfred on 14-10-5.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZUserDefault.h"

@implementation ZZZUserDefault

//延迟实例化
//只能用_xxx,不能用self.xxx,我也不知道为什么
-(NSUserDefaults *)userDefaults
{
   if (_userDefaults == nil){
      _userDefaults = [NSUserDefaults standardUserDefaults];
   }
   return _userDefaults;
}

// 保存 登录or注册
-(void)saveUserDefaults: (NSArray *)savedDefaults
{
   //NSArray里保存了两个字符串，分别是phone & password
   //NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   
   [self.userDefaults setObject:savedDefaults[0] forKey:@"cellphone"];
   [self.userDefaults setObject:@"in" forKey:@"inOrOut"];
   NSLog(@"%@", savedDefaults);
   NSLog(@"userDefaults saved");
   
}

// 退出登录
-(void)logoutUserDefaults
{
   [self.userDefaults setObject:@"out" forKey:@"inOrOut"];
}

// 读取当前登录账号
-(NSString *)readUserDefaults
{
   NSString *sr = [self.userDefaults stringForKey:@"cellphone"];
   NSLog(@"account now: %@", sr);
   return sr;
}

// 检查当前是否登录
-(NSString *)inOrOutUserDefaults
{
   NSString *inOrOut = [self.userDefaults stringForKey:@"inOrOut"];
   NSLog(@"is login ?: %@", inOrOut);
   return inOrOut;
}

// 读写device token
-(NSString *)readDeviceToken
{
   NSString *deviceToken = [self.userDefaults stringForKey:@"deviceToken"];
   return deviceToken;
}
-(void)writeDeviceToken:(NSString *)deviceToken
{
   [self.userDefaults setObject:deviceToken forKey:@"deviceToken"];
}



@end
