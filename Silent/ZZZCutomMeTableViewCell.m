//
//  ZZZCutomMeTableViewCell.m
//  Silent
//
//  Created by alfred on 14-10-19.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZCutomMeTableViewCell.h"

@implementation ZZZCutomMeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma my code:

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self) {
      // Initialization code
      /*
       CGRect nameLabelRect = CGRectMake(0, 5, 70, 20);
       UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
       nameLabel.text = @"Name:";
       nameLabel.font = [UIFont boldSystemFontOfSize:15];
       [self.contentView addSubview: nameLabel];
      */
      
      _screenHeight = [UIScreen mainScreen].bounds.size.height;
      _screenWidth = [UIScreen mainScreen].bounds.size.width;
      //NSLog(@"screen size: %ld,%ld", (long)_screenHeight, (long)_screenWidth);
      
      _cellTitleText = @"hello kitty";
      
      CGRect nameValueRect = CGRectMake(20, 16, _screenWidth-20-20, 20);
      _cellTitleLabel = [[UILabel alloc] initWithFrame:nameValueRect];
      _cellTitleLabel.text = _cellTitleText;
      _cellTitleLabel.font = [UIFont boldSystemFontOfSize:16];
      _cellTitleLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
      [self.contentView addSubview:_cellTitleLabel];
      
      // not usefull
      self.frame = CGRectMake(0, 0, 300, 100);
      NSLog(@"%f", self.frame.size.height);
      
   }
   return self;
}

-(void)setCellTitleText:(NSString *)n
{
   if (![n isEqualToString:_cellTitleText]) {
      _cellTitleText = [n copy];
      _cellTitleLabel.text = _cellTitleText;
      
      // 设置文本折行
      /*
      NSString *str = _cellTitleText;
      CGSize maxSize = {200, 5000};
      CGSize labelSize = [str sizeWithFont:[UIFont boldSystemFontOfSize:15]
      constrainedToSize:maxSize
      lineBreakMode:_cellTitleLabel.lineBreakMode];   // str是要显示的字符串
      _cellTitleLabel.frame = CGRectMake(20, 10, labelSize.width, labelSize.height);
      //[_name sizeToFit]; // 设置label顶端对齐
      _cellTitleLabel.numberOfLines = 0;  // 不可少Label属性之一
      //_name.lineBreakMode = UILineBreakModeCharacterWrap;  // 不可少Label属性之二
       */

      // 作为分割线的色块
      UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(0, 54, _screenWidth, 2.5)];
      partLine.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1]; //背景灰
      [self.contentView addSubview:partLine];
      
   }
}

@end
