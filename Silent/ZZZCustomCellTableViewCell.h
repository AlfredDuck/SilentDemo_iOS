//
//  ZZZCustomCellTableViewCell.h
//  Silent
//
//  Created by alfred on 14-10-19.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//  Customed TableViewCell 
//

#import <UIKit/UIKit.h>

@interface ZZZCustomCellTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, copy) UILabel *nameLabel;
//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@end
