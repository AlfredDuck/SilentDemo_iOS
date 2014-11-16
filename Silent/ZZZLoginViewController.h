//
//  ZZZLoginViewController.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZZLoginConnect.h"


@interface ZZZLoginViewController : UIViewController <loginConnectDelegate>

@property (nonatomic, strong) UITextField *fieldCellphone;
@property (nonatomic, strong) UITextField *fieldPassword;

//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
