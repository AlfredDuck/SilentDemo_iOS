//
//  ZZZLogoutConnect.h
//  Silent
//
//  Created by alfred on 14-11-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZZLogoutConnect : NSObject
@property (strong, nonatomic) NSURLConnection *logoutConnection;
@property (strong, nonatomic) NSMutableData *logoutData;
-(void)startConnect:(NSString *)cellphone;
@end
