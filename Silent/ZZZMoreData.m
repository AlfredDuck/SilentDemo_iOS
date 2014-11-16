//
//  ZZZMoreData.m
//  Silent
//
//  Created by alfred on 14-10-8.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZMoreData.h"

@implementation ZZZMoreData

//-------Connection Start--------

-(void)startConnect:(NSString *)cellphone skip:(int)skip
{
   NSLog(@"prepare get message connection");
   //step 0.5: 准备POST请求参数
   NSLog(@"邮箱：%@", cellphone);
   NSString *str1 = [@"owner=" stringByAppendingString: cellphone];
   NSString *s = [NSString stringWithFormat: @"%d", skip];
   NSString *str2 = [@"&skip=" stringByAppendingString: s];
   NSString *str = [str1 stringByAppendingString:str2];
   
   //step 1:请求地址
   NSString *urlString = @"http://127.0.0.1:18080/get_message";
   NSURL *url = [NSURL URLWithString:urlString];
   //step 2:实例化一个request
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
   //
   [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
   //
   NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
   [request setHTTPBody:data];
   
   //step 3：创建链接
   self.getMessageConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   if ( self.getMessageConnection) {
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
   self.callbackData = d;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   //接受返回数据，这个方法可能会被调用多次，因此将多次返回数据加起来
   
   NSUInteger datalength = [data length];
   NSLog(@"返回数据量：%d",datalength);
   [self.callbackData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   //连接结束
   NSLog(@"%d:",[self.callbackData length]);
   NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
   NSString *mystr = [[NSString alloc] initWithData:_callbackData encoding:enc];
   //
   NSLog(@"signup请求的返回值：%@",mystr);
   
   //解析json
   NSError *error;
   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self.callbackData options:NSJSONReadingMutableLeaves error:&error];
   
   NSString *jsonName = [dictionary objectForKey:@"name"];
   NSArray *jsonContent = [dictionary objectForKey:@"content"];
   
   // 调用代理方法
   [self.delegate addMoreMessages:jsonContent];
   
   NSLog(@"%@", jsonName);
   NSLog(@"%lu", (unsigned long)[jsonContent count]);
   
   NSDictionary *dic = [jsonContent objectAtIndex:0];
   NSLog(@"%@", [dic objectForKey:@"text"]);
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   //链接错误
   NSLog(@"返回出错");
}
//-------Connection End--------



@end
