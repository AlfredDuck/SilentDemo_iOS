//
//  ZZZFriendsViewController.h
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZZAddressBook.h"

@interface ZZZFriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, showAddressBook>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UITableView *friendsTableView;
@property (nonatomic, copy) UILabel *friendNameLabel;
//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
