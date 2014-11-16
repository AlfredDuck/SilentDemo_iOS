//
//  ZZZSignupConnect.h
//  Silent
//
//  Created by alfred on 14-10-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol signupConnectDelegate <NSObject>
@required
-(void)signupConnectDelegate:(NSDictionary *)json;
@end

@interface ZZZSignupConnect : NSObject
@property (strong, nonatomic) NSURLConnection *signupConnection;
@property (strong, nonatomic) NSMutableData *callbackData;
@property (nonatomic, assign) id <signupConnectDelegate> delegate; // 设置代理
-(void)startConnect:(NSString *)cellphone password:(NSString *)password deviceToken:(NSString *)token;
@end
