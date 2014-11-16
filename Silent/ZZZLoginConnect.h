//
//  ZZZLoginConnect.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol loginConnectDelegate <NSObject>
@required
-(void)loginConnectDelegate:(NSDictionary *)json;
@end

@interface ZZZLoginConnect : NSObject
@property (strong, nonatomic) NSURLConnection *loginConnection;
@property (strong, nonatomic) NSMutableData *loginData;
@property (nonatomic, assign) id <loginConnectDelegate> delegate; //定义代理
-(void)startConnect:(NSString *)cellphone password:(NSString *)password deviceToken:(NSString *)token;
@end
