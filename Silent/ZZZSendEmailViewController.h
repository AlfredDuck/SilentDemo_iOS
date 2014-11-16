//
//  ZZZSendEmailViewController.h
//  Silent
//
//  Created by alfred on 14-10-26.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZZSendEmailConnect.h"

@interface ZZZSendEmailViewController : UIViewController<sendEmailConnectDelegate>
@property (nonatomic, strong) UITextField *fieldEmail;  // 收信人地址
@property (nonatomic, strong) NSString *recieverCellphone;  // 收信人的电话
@property (nonatomic, strong) NSString *recieverText;  // 收信内容
@property (nonatomic, strong) UIActivityIndicatorView *loadingButton;  // 小菊花
@property (nonatomic, strong) UIButton *sendButton; // 发送按钮
//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
