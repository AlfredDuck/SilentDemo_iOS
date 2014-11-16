//
//  ZZZSilentViewController.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZZGetMessages.h"
#import "ZZZMoreData.h"
#import "ZZZSendMessageViewController.h"

@interface ZZZSilentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, messageConnectDelegate>
// 数据源
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, copy) UILabel *messageLabel;
// 分页计数&步数
@property (nonatomic) int pullSkip;
@property (nonatomic) int pullStep;

@property (nonatomic, strong) UITableView *silentTableView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingButton;
@property (nonatomic, strong) UIImageView *refreshImageView;
@property (nonatomic, strong) UILabel *emptyLabel;

//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@property (nonatomic, strong) NSTimer *timerRefresh;
@property (nonatomic, strong) NSTimer *timerAddMore;
@end
