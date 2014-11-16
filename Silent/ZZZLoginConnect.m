//
//  ZZZLoginConnect.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZLoginConnect.h"
#import "ZZZUserDefault.h"
#import "ZZZURLManager.h"

@implementation ZZZLoginConnect

//-------Connection Start--------
- (void)startConnect:(NSString *)cellphone password:(NSString *)password deviceToken:(NSString *)token
{
   NSLog(@"prepare login connection");
   //step 0.5: 准备POST请求参数
   NSLog(@"邮箱：%@", cellphone);
   NSLog(@"密码：%@", password);
   NSString *str1 = [@"cellphone=" stringByAppendingString: cellphone];
   NSString *str2 = [@"&password=" stringByAppendingString: password];
   NSString *str3 = [@"&deviceToken=" stringByAppendingString:token];
   
   //step 1:请求地址
   NSString *urlString = [[ZZZURLManager getHomePath] stringByAppendingString:[ZZZURLManager getLoginPath]];
   NSURL *url = [NSURL URLWithString:urlString];
   //step 2:实例化一个request
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
   //
   [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
   //  NSString *str1 = @"phone=15061509606";//设置参数
   //  NSString *str2 = @"&password=123456";
   NSString *str = [str1 stringByAppendingString:str2];
   str = [str stringByAppendingString:str3];
   NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
   [request setHTTPBody:data];
   
   //step 3：创建链接
   self.loginConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   if ( self.loginConnection) {
      NSLog(@"链接成功");
   }else {
      NSLog(@"链接失败");
   }

}

#pragma NSUrlConnectionDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   //接受一个服务端回话，再次一般初始化接受数据的对象
   
   NSLog(@"返回数据类型：%@",[response textEncodingName]);
   NSMutableData *d = [[NSMutableData alloc] init];
   self.loginData = d;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   //接受返回数据，这个方法可能会被调用多次，因此将多次返回数据加起来
   
   NSUInteger datalength = [data length];
   NSLog(@"返回数据量：%d",datalength);
   [self.loginData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   //连接结束
   NSLog(@"%d:",[self.loginData length]);
   NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
   NSString *mystr = [[NSString alloc] initWithData:_loginData encoding:enc];
   //
   NSLog(@"登录请求的返回值：%@",mystr);
   
   //解析json
   NSError *error;
   NSDictionary *callBackDictionary = [NSJSONSerialization JSONObjectWithData:self.loginData options:NSJSONReadingMutableLeaves error:&error];
   NSString *cellphone = [callBackDictionary objectForKey:@"cellphone"];
   NSString *success = [callBackDictionary objectForKey:@"success"];
   NSLog(@"%@", cellphone);
   NSLog(@"%@", success);
   
   // 调用代理方法 此代理只负责把登录返回值传到 LoginViewController
   [self.delegate loginConnectDelegate:callBackDictionary];
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   //链接错误
}
//-------Connection End--------

@end
