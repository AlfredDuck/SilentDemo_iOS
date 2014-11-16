//
//  ZZZCustomCellTableViewCell.m
//  Silent
//
//  Created by alfred on 14-10-19.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZCustomCellTableViewCell.h"

@implementation ZZZCustomCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark my code:

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self) {
      // Initialization code
      /*
       CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
       UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
       nameLabel.text = @"Name:";
       nameLabel.font = [UIFont boldSystemFontOfSize:12];
       [self.contentView addSubview: nameLabel];
       
       CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
       UILabel *nameValue = [[UILabel alloc] initWithFrame:nameValueRect];
       nameValue.tag = kNameValueTag;
       [self.contentView addSubview:nameValue];
       */
      
      _screenHeight = [UIScreen mainScreen].bounds.size.height;
      _screenWidth = [UIScreen mainScreen].bounds.size.width;
      //NSLog(@"screen size: %ld,%ld", (long)_screenHeight, (long)_screenWidth);
      
      _name = @"hello kitty";
      
      CGRect nameValueRect = CGRectMake(20, 16, _screenWidth-20-20, 20);
      _nameLabel = [[UILabel alloc] initWithFrame:nameValueRect];
      _nameLabel.text = _name;
      _nameLabel.font = [UIFont boldSystemFontOfSize:16];
      _nameLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
      [self.contentView addSubview:_nameLabel];
      
      // not usefull
      self.frame = CGRectMake(0, 0, 300, 100);
      NSLog(@"%f", self.frame.size.height);
      
   }
   return self;
}

-(void)setName:(NSString *)n
{
   if (![n isEqualToString:_name]) {
      _name = [n copy];
      _nameLabel.text = _name;
      // 这里重写setter方法是为了_nameLabel，而不是_name
      
      // 作为分割线的色块
      UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(0, 54, _screenWidth, 2.5)];
      partLine.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1]; //背景灰
      [self.contentView addSubview:partLine];
      
   }
}

@end
