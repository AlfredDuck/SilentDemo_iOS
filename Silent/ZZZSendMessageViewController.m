//
//  ZZZSendMessageViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZSendMessageViewController.h"
#import "ZZZSendMessageConnect.h"
#import "ZZZSendEmailViewController.h"

@interface ZZZSendMessageViewController ()

@end

@implementation ZZZSendMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.view.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1]; //文本背景灰色
    }
    return self;
}

-(void)loadView
{
   [super loadView];
   // 获取屏幕长宽（pt）
   _screenHeight = [UIScreen mainScreen].bounds.size.height;
   _screenWidth = [UIScreen mainScreen].bounds.size.width;
   NSLog(@"screen size: %ld,%ld", (long)_screenHeight, (long)_screenWidth);
   
   // title bar background
   UIView *titleBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, 64)];
   titleBarBackground.backgroundColor = [UIColor colorWithRed:(57/255.0) green:(201/255.0) blue:(183/255.0) alpha:1];
   [self.view addSubview:titleBarBackground];
   
   //back button
   /*
   UIButton *goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 27, 80, 30)];
   [goBackButton setTitle:@"Back" forState:UIControlStateNormal];
   goBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   goBackButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
   [goBackButton addTarget:self action:@selector(clickGoBackButton) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: goBackButton];
   */
   
   // back button pic
   UIImage *oneImage = [UIImage imageNamed:@"Back_button.png"]; // 使用ImageView通过name找到图片
   UIImageView *oneImageView = [[UIImageView alloc] initWithImage:oneImage]; // 把oneImage添加到oneImageView上
   oneImageView.frame = CGRectMake(0, 20, 44, 44); // 设置图片位置和大小
   // 为图片添加点击事件
   // 一定要先将userInteractionEnabled置为YES，这样才能响应单击事件
   oneImageView.userInteractionEnabled = YES; // 设置图片可以交互
   UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoBackButton)]; // 设置手势
   [oneImageView addGestureRecognizer:singleTap]; // 给图片添加手势
   [self.view addSubview:oneImageView];
   
   //send button
   _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth-48, 20, 48, 44)];
   [_sendButton setTitle:@"Send" forState:UIControlStateNormal];
   _sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   _sendButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
   [_sendButton addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: _sendButton];
   
   // message text view
   _messageTextView = [[UITextView alloc] init];
   _messageTextView.frame = CGRectMake(15, 74, _screenWidth-15-15, 200);
   _messageTextView.backgroundColor = [UIColor colorWithRed:(57/255.0) green:(201/255.0) blue:(183/255.0) alpha:0];
   //_messageTextView.text = @"type in your anonymous message..."; //默认显示的字
   _messageTextView.font = [UIFont fontWithName:@"Helvetica" size:15];; // 设置字体大小
   _messageTextView.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1]; // 设置文字颜色
   _messageTextView.delegate = self;  // fuck!!!!!
   [self.view addSubview:_messageTextView];
   
   // custom placeholder
   _placeHolder = [[UILabel alloc] init];
   _placeHolder.text = @"type in your anonymous message...";
   _placeHolder.frame = CGRectMake(20, 74, _screenWidth-15-15, 30);
   _placeHolder.textColor = [UIColor lightGrayColor];
   _placeHolder.font = [UIFont fontWithName:@"Helvetica" size:15];
   [self.view addSubview:_placeHolder];
   
   
   // 小菊花
   _loadingButton = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
   //_loadingButton.center = self.view.center;
   _loadingButton.frame = CGRectMake(_screenWidth-50, 17, 50, 50);
   //[_loadingButton startAnimating];
   //[_loadingButton stopAnimating];
   [self.view addSubview:_loadingButton];

}

- (void)viewDidLoad
{
   [super viewDidLoad];
   [_messageTextView becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
   // titel "to xxx"
   // 因为涉及到读取self的属性，所以应该等view加载完成
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, _screenWidth-100, 44)];
   titleLabel.text = self.titleOfView;
   titleLabel.textColor = [UIColor whiteColor];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 15];
   titleLabel.textAlignment = UITextAlignmentCenter;
   [self.view addSubview:titleLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}






/*
 *
 * textview 代理方法
 *
 *
 */
-(void)textViewDidChange:(UITextView *)textView
{
   NSLog(@"开始写字");
   _placeHolder.alpha = 0;
   [textView becomeFirstResponder];
}






/*
 * IBAction 方法
 *
 *
 *
 *
 */

-(void)clickSendButton
{
   NSLog(@"clickSendButton");
   
   // 准备send message物料
   NSString *text = nil;
   NSString *fieldText = _messageTextView.text;
   NSString *from = _sendFrom;
   NSString *to = _sendTo;
   
   // 输入为空不能发送
   if ([fieldText isEqualToString:@""]){
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Message?" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      [alert show];
      return;
   }
   
   // 小菊花
   [_loadingButton startAnimating];
   [_sendButton setHidden:YES];
   
   if (_withReply != nil) {
      text = [fieldText stringByAppendingFormat:@"%@%@", @" <Re>: ", _withReply];
   } else {
      text = fieldText;
   }
   _sendText = text;
   
   // 执行send message请求
   ZZZSendMessageConnect *sendMessageConnect = [[ZZZSendMessageConnect alloc] init];
   sendMessageConnect.delegate = self;
   [sendMessageConnect startConnect:text from:from to:to];
   sendMessageConnect = nil;
}

// go back
-(void)clickGoBackButton
{
   [self.navigationController popViewControllerAnimated:YES];
}






/*
 * 私有方法
 *
 *
 *
 *
 */
-(void)postNotificationToSilent
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshSilent" object:@"This is posterone!"];
}






/*
 * 实现代理方法
 *
 *
 *
 *
 */
-(void)sendMessageConnectDelegate:(NSDictionary *)callbackDictionary
{
   NSString *isToSignup = [callbackDictionary objectForKey:@"isToSignup"];
   NSString *isSendSuccess = [callbackDictionary objectForKey:@"isSendSuccess"];

   if ([isSendSuccess isEqualToString:@"yes"] && [isToSignup isEqualToString:@"yes"]) {
      // 发送notification，通知silent页面刷新
      [self postNotificationToSilent];
      // 发送成功，退出自身
      [self.navigationController popViewControllerAnimated:YES];
   }
   else if ([isSendSuccess isEqualToString:@"yes"] && [isToSignup isEqualToString:@"no"]) {
      // 收信人不是注册用户，开启sendEmailVC模态视图
      ZZZSendEmailViewController *sendEmailVC = [[ZZZSendEmailViewController alloc] init];
      sendEmailVC.recieverCellphone = _sendTo;
      sendEmailVC.recieverText = _sendText;
      [self presentViewController:sendEmailVC animated:YES completion:Nil];
      
      // 发送notification，通知silent页面刷新
      [self postNotificationToSilent];
      // 发送成功，退出自身
      [self.navigationController popViewControllerAnimated:YES];
   }
   else {

      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"err" message:@"connect err" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
      //alert.alertViewStyle = UIAlertViewStylePlainTextInput;
      [alert show];
   }

   /*
   if ([isToSignup isEqualToString:@"no"]) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tom isn't in Silent" message:@"Add his E-mail, we would send this messge to him Anonymously" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
      alert.alertViewStyle = UIAlertViewStylePlainTextInput;
      [alert show];
   }
    */
}


/*
-(void)getBackFromSendMessageVC
{
   // 调用代理方法
   NSDictionary *newMessage = [[NSDictionary alloc] initWithObjectsAndKeys:_sendText, @"text", _sendFrom, @"from", _sendTo, @"to", nil];
   [self.delegate addSendedMessageToList:newMessage];
   // 退出自身
   [self.navigationController popViewControllerAnimated:YES];
}
*/
@end
