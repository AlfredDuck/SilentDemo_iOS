//
//  ZZZMoreData.h
//  Silent
//
//  Created by alfred on 14-10-8.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol addMoreMessages <NSObject>

@required
-(void)addMoreMessages:(NSArray *)messages;

@end

@interface ZZZMoreData : NSObject<NSURLConnectionDelegate>

@property (strong, nonatomic) NSURLConnection *getMessageConnection;
@property (strong, nonatomic) NSMutableData *callbackData;
//网络获取的message
@property (strong, nonatomic) NSArray *messageData;

// 发送当前用户手机号,要查询的分页,给服务器
-(void)startConnect:(NSString *)cellphone skip:(int)skip;

// 设置代理
@property (nonatomic, assign) id <addMoreMessages> delegate;

@end
