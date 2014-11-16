//
//  ZZZSendMessageConnect.h
//  Silent
//
//  Created by alfred on 14-10-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol sendMessageConnectDelegate <NSObject>
@required
-(void)sendMessageConnectDelegate:(NSDictionary *)callbackDictionary;
@end


@interface ZZZSendMessageConnect : NSObject

@property (strong, nonatomic) NSURLConnection *sendMessageConnection;
@property (strong, nonatomic) NSMutableData *callbackData;
// 设置代理
@property (nonatomic, assign) id <sendMessageConnectDelegate> delegate;

-(void)startConnect:(NSString *)sendText from:(NSString *)sendFrom to:(NSString *)sendTo;

@end
