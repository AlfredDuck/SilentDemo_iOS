//
//  ZZZUserDefault.h
//  Silent
//
//  Created by alfred on 14-10-5.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZZUserDefault : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;

-(void)saveUserDefaults: (NSArray *)userInfor;
-(void)logoutUserDefaults;
-(NSString *)readUserDefaults;
-(NSString *)inOrOutUserDefaults;
-(NSString *)readDeviceToken;
-(void)writeDeviceToken:(NSString *)deviceToken;

@end
