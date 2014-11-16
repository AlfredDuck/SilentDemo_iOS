//
//  ZZZGetMessages.h
//  Silent
//
//  Created by alfred on 14-10-4.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//
/*
 * 第一次message请求和load more messages 请求分开是有好处的，虽然会让程序臃肿一些
 */

#import <Foundation/Foundation.h>

@protocol messageConnectDelegate <NSObject>
@required
-(void)messageConnectDelegate:(NSArray *)messages;
@end

@interface ZZZGetMessages : NSObject

@property (strong, nonatomic) NSURLConnection *getMessageConnection;
@property (strong, nonatomic) NSMutableData *callbackData;
@property (strong, nonatomic) NSArray *messageData;        //网络获取的message
@property (assign, nonatomic) id <messageConnectDelegate> delegate;  // 设置代理

-(void)startConnect:(NSString *)cellphone skip:(int)skip;

@end
