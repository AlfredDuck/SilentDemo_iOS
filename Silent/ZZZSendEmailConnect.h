//
//  ZZZSendEmailConnect.h
//  Silent
//
//  Created by alfred on 14-10-26.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol sendEmailConnectDelegate <NSObject>
@required
-(void)sendEmailConnectDelegate:(NSDictionary *)callbackDictionary;
@end


@interface ZZZSendEmailConnect : NSObject
@property (strong, nonatomic) NSURLConnection *sendMessageConnection;
@property (strong, nonatomic) NSMutableData *callbackData;
@property (nonatomic, assign) id <sendEmailConnectDelegate>delegate; // 设置代理

-(void)startConnect:(NSString *)email cellphone:(NSString *)cellphone text:(NSString *)text;
@end
