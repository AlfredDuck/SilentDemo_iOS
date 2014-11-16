//
//  ZZZSendMessageViewController.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZZSendMessageConnect.h"

@protocol addSendedMessageToList <NSObject>
// 将发送成功的message添加到silent页面
@required
-(void)addSendedMessageToList:(NSDictionary *)newMessage;
@end


@interface ZZZSendMessageViewController : UIViewController<sendMessageConnectDelegate, UITextViewDelegate>
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UILabel *placeHolder;
@property (nonatomic, strong) NSString *sendTo;
@property (nonatomic, strong) NSString *sendFrom;
@property (nonatomic, strong) NSString *sendText;
@property (nonatomic, strong) NSString *titleOfView;
@property (nonatomic, strong) NSString *withReply;
@property (nonatomic, assign) id <addSendedMessageToList> delegate;  // 设置代理
@property (nonatomic, strong) UIActivityIndicatorView *loadingButton;  // 小菊花
@property (nonatomic, strong) UIButton *sendButton; // 发送按钮

//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
