//
//  ZZZCustomSilentTableViewCell.m
//  Silent
//
//  Created by alfred on 14-10-19.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZCustomSilentTableViewCell.h"

@implementation ZZZCustomSilentTableViewCell

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
      
      _cellMessageText = @"hello kitty";
      
      CGRect nameValueRect = CGRectMake(20, 18.5, _screenWidth-20-20, 20);
      _cellMessageLabel = [[UILabel alloc] initWithFrame:nameValueRect];
      _cellMessageLabel.text = _cellMessageText;
      _cellMessageLabel.font = [UIFont boldSystemFontOfSize:16];
      _cellMessageLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
      [self.contentView addSubview:_cellMessageLabel];
      
      // not usefull
      //self.frame = CGRectMake(0, 0, 300, 100);
      //NSLog(@"%f", self.frame.size.height);
      
   }
   return self;
}

-(void)setCellMessageText:(NSString *)n
{
   if (![n isEqualToString:self.cellMessageText]) {
      _cellMessageText = [n copy];
      _cellMessageLabel.text = _cellMessageText;
      
      
      // 设置文本折行
      NSString *str = _cellMessageText;
      CGSize maxSize = {_screenWidth-20-20, 5000};
      CGSize labelSize = [str sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:maxSize lineBreakMode:_cellMessageLabel.lineBreakMode];   // str是要显示的字符串
      _cellMessageLabel.frame = CGRectMake(20, 18.5, labelSize.width, labelSize.height);
      //[_name sizeToFit]; // 设置label顶端对齐
      _cellMessageLabel.numberOfLines = 0;  // 不可少Label属性之一
      //_name.lineBreakMode = UILineBreakModeCharacterWrap;  // 不可少Label属性之二
      
      
      // 作为分割线的色块
      if (![self.contentView viewWithTag:130]){
         UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, 2.5)];
         partLine.tag = 130;
         partLine.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1];
         [self.contentView addSubview:partLine];
      }
      
   }
}

-(void)loadDataToCellLabel:(NSString *)string
{
   self.cellMessageLabel.text = string;
}

@end
