//
//  ZZZCustomSilentTableViewCell.h
//  Silent
//
//  Created by alfred on 14-10-19.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZZCustomSilentTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *cellMessageText;
@property (nonatomic, copy) UILabel *cellMessageLabel;

//
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;

-(void)loadDataToCellLabel:(NSString *)string;

@end
