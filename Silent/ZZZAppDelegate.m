//
//  ZZZAppDelegate.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZAppDelegate.h"
#import "ZZZMainViewController.h"
#import "ZZZUserDefault.h"
#import "ZZZUpdateTokenConnect.h"

@implementation ZZZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   
   //my code:
   
   //设置tabbarcontroller为rootVC
   ZZZMainViewController *mainVC = [[ZZZMainViewController alloc] init];
   self.window.rootViewController = mainVC;
   
   // 设置状态栏为白色
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   
   // 允许推送，暂时不懂
   [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
    (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
   
   // app开启后清除badge(图标上的小红点)
   [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
   
   //根据系统版本不同，调用不同方法获取 device token
   if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
   #ifdef __IPHONE_8_0
      //Right, that is the point
      UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
      [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
   #else
      //register to receive notifications
      UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
      [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
   #endif
   }
   
    return YES;
}

/*
 * 获取设备token
 *
 *
 *
 */

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
   //register to receive notifications
   [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
   //handle the actions
   if ([identifier isEqualToString:@"declineAction"]){
   }
   else if ([identifier isEqualToString:@"answerAction"]){
   }
}
#endif


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   
   NSString *tokenStr = [NSString
                    stringWithFormat:@"%@",deviceToken];
   NSLog(@"device token:");
   NSLog(@"%@",tokenStr);
   
   NSString *tokenStrWithoutBlankChar = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
   tokenStrWithoutBlankChar = [tokenStrWithoutBlankChar stringByReplacingOccurrencesOfString:@"<" withString:@""];
   tokenStrWithoutBlankChar = [tokenStrWithoutBlankChar stringByReplacingOccurrencesOfString:@">" withString:@""];
   NSLog(@"去掉空格的token：%@", tokenStrWithoutBlankChar);
   
   // 检查本地记录的device token
   ZZZUserDefault *userDef = [[ZZZUserDefault alloc] init];
   NSLog(@"本地记录的device token:%@",[userDef readDeviceToken]);
   if (![userDef readDeviceToken]) {
      NSLog(@"无本地记录的device token");
      [userDef writeDeviceToken:tokenStrWithoutBlankChar];
   }
   else if (![[userDef readDeviceToken] isEqualToString:tokenStrWithoutBlankChar]) {
      NSLog(@"本地记录的token与实际token不符");
      [userDef writeDeviceToken:tokenStrWithoutBlankChar];
      
      // 检查是否登录着，如果登录着则更新服务器的用户设备token
      if ([[userDef inOrOutUserDefaults] isEqualToString:@"in"]) {
         NSLog(@"打印登录信息： %@", [userDef readUserDefaults]);
         
         ZZZUpdateTokenConnect *updateTokenConnect = [[ZZZUpdateTokenConnect alloc] init];
         [updateTokenConnect startConnect:[userDef readUserDefaults] deviceToken:tokenStrWithoutBlankChar];
         updateTokenConnect = nil;
      }
      
   }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
   
   NSString *str = [NSString stringWithFormat: @"Error: %@", err];
   NSLog(@"%@",str);
   
}


- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   if ( application.applicationState == UIApplicationStateActive ) {
      // 程序在运行过程中受到推送通知
      NSLog(@"%@", [[userInfo objectForKey: @"aps"] objectForKey: @"alert"]);
   } else {
      //程序未在运行状态受到推送通知
   }
}



// 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
   return UIInterfaceOrientationMaskPortrait;
}




/*
 * 暂时用不上的一些
 *
 *
 *
 */

- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // app开启后清除badge(图标上的小红点)
   [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
