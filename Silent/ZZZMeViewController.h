//
//  ZZZMeViewController.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZZMeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *meTableView;
@property (nonatomic, strong) NSArray *meTableViewData;

@property (nonatomic, copy) UILabel *name;
@property (nonatomic, copy) UILabel *color;

//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
