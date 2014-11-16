//
//  ZZZSendMessageConnect.m
//  Silent
//
//  Created by alfred on 14-10-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZSendMessageConnect.h"
#import "ZZZURLManager.h"

@implementation ZZZSendMessageConnect

//-------Connection Start--------
-(void)startConnect:(NSString *)sendText from:(NSString *)sendFrom to:(NSString *)sendTo{
   NSLog(@"prepare login connection");
   //step 0.5: 准备POST请求参数
   NSLog(@"message：%@", sendText);
   NSLog(@"from：%@", sendFrom);
   NSLog(@"to：%@", sendTo);
   NSString *str1 = [@"text=" stringByAppendingString: sendText];
   NSString *str2 = [@"&from=" stringByAppendingString: sendFrom];
   NSString *str3 = [@"&to=" stringByAppendingString: sendTo];
   
   //step 1:请求地址
   NSString *urlString = [[ZZZURLManager getHomePath] stringByAppendingString:[ZZZURLManager getSendMessagePath]];
   NSURL *url = [NSURL URLWithString:urlString];
   //step 2:实例化一个request
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
   //
   [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
   NSString *str = [str1 stringByAppendingFormat:@"%@%@",str2, str3];
   NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
   [request setHTTPBody:data];
   
   //step 3：创建链接
   self.sendMessageConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   if ( self.sendMessageConnection) {
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
   NSLog(@"send message 请求的返回值：%@",mystr);
   
   //解析json
   NSError *error;
   NSDictionary *callbackDictionary = [NSJSONSerialization JSONObjectWithData:self.callbackData options:NSJSONReadingMutableLeaves error:&error];
   NSString *isToSignup = [callbackDictionary objectForKey:@"isToSignup"];
   NSString *isSendSuccess = [callbackDictionary objectForKey:@"isSendSuccess"];
   NSLog(@"%@", isToSignup);
   NSLog(@"%@", isSendSuccess);
   
   // 调用代理方法，将数据传回sendmessageVC
   [self.delegate sendMessageConnectDelegate:callbackDictionary];
   
   //alertView委托方法
   /*
   .m里面增加下面的
   - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
      // the user clicked OK
      if (buttonIndex == 0)
      {
         //do something here...
      }
   }
   
   .h里面增加<UIAlertViewDelegate>
   @interface YourViewController : UIViewController <UIAlertViewDelegate>
   */
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   //链接错误
}
//-------Connection End--------

@end
