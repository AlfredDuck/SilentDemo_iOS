//
//  ZZZUpdateTokenConnect.h
//  Silent
//
//  Created by alfred on 14-11-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZZUpdateTokenConnect : NSObject
@property (strong, nonatomic) NSURLConnection *updateTokenConnection;
@property (strong, nonatomic) NSMutableData *updateTokenData;
-(void)startConnect:(NSString *)cellphone deviceToken:(NSString *)token;
@end
