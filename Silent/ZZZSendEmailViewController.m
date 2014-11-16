//
//  ZZZSendEmailViewController.m
//  Silent
//
//  Created by alfred on 14-10-26.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZSendEmailViewController.h"
#import "ZZZSendEmailConnect.h"

@interface ZZZSendEmailViewController ()

@end

@implementation ZZZSendEmailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
      self.title = @"send email";
      self.view.backgroundColor = [UIColor colorWithRed:(57/255.0) green:(201/255.0) blue:(183/255.0) alpha:1];
   }
   return self;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   // 获取屏幕长宽（pt）
   _screenHeight = [UIScreen mainScreen].bounds.size.height;
   _screenWidth = [UIScreen mainScreen].bounds.size.width;
   
   // title
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 240, 44)];
   titleLabel.text = @"Add His/Her Email";
   titleLabel.textColor = [UIColor whiteColor];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 24];
   [self.view addSubview:titleLabel];
   
   // close button pic
   UIImage *oneImage = [UIImage imageNamed:@"Close_button.png"]; // 使用ImageView通过name找到图片
   UIImageView *closeImageView = [[UIImageView alloc] initWithImage:oneImage]; // 把oneImage添加到oneImageView上
   closeImageView.frame = CGRectMake(_screenWidth-46, 20, 44, 44); // 设置图片位置和大小
   // 为图片添加点击事件
   // 一定要先将userInteractionEnabled置为YES，这样才能响应单击事件
   closeImageView.userInteractionEnabled = YES; // 设置图片可以交互
   UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leavePage)]; // 设置手势
   [closeImageView addGestureRecognizer:singleTap]; // 给图片添加手势
   [self.view addSubview:closeImageView];
   
   UIView *blackView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 74, _screenWidth-20, 54)];
   blackView1.backgroundColor  = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   [self.view addSubview:blackView1];
   
   //email textfield
   _fieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, _screenWidth-20-15, 54)];
   [_fieldEmail setBorderStyle:UITextBorderStyleNone]; //外框类型
   _fieldEmail.placeholder = @"His/Her Email"; //默认显示的字
   _fieldEmail.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   _fieldEmail.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   _fieldEmail.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   [blackView1 addSubview:_fieldEmail];
   
   // 设置placeholder的文本和颜色
   if ([_fieldEmail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
      UIColor *color = [UIColor lightGrayColor];
      _fieldEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"His/Her Email" attributes:@{NSForegroundColorAttributeName: color}];
   } else {
      NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
      // TODO: Add fall-back code to set placeholder color.
   }
   
   // introduction label
   UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74+64, _screenWidth-20, 16)];
   introduceLabel.text = @"To remind him/her to view messages";
   introduceLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   introduceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 13];
   [self.view addSubview:introduceLabel];
   
   //send button
   _sendButton= [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth-110, 74+64+30, 310, 44)];
   _sendButton.backgroundColor = [UIColor colorWithRed:(13/255.0) green:(172/255.0) blue:(170/255.0) alpha:1];
   _sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   _sendButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
   [_sendButton setTitle:@"   SEND" forState:UIControlStateNormal];
   [_sendButton addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: _sendButton];
   
   // 小菊花
   _loadingButton = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
   _loadingButton.frame = CGRectMake(_screenWidth-50-20, 2, 50, 50);
   [blackView1 addSubview:_loadingButton];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
 * 实现IBAction方法
 *
 *
 *
 *
 */
-(void)clickSendButton
{
   NSLog(@"clickSendButton");
   
   // 输入为空不能发送
   if ([_fieldEmail.text isEqualToString:@""]) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty?" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      [alert show];
      return;
   }
   else {
      // 判断邮箱格式
      NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
      NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
      if (![emailTest evaluateWithObject:_fieldEmail.text])
      {
         NSLog(@"email格式错误");
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong e-mail" message:@"Wrong e-mail" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
         return;
      }
   }

   
   // 小菊花
   [_loadingButton startAnimating];
   [_sendButton setHidden:YES];
   
   //
   ZZZSendEmailConnect *sendEmailConnect = [[ZZZSendEmailConnect alloc] init];
   NSString *email = _fieldEmail.text;
   sendEmailConnect.delegate = self;  // 代理授权
   [sendEmailConnect startConnect:email cellphone:_recieverCellphone text:_recieverText];
   
}

-(void)leavePage
{
   NSLog(@"leavePage");
   //将自己退出modal视图
   [self dismissViewControllerAnimated:YES completion:nil];
}





/*
 * 实现代理方法
 *
 *
 *
 *
 */
-(void)sendEmailConnectDelegate:(NSDictionary *)callbackDictionary
{
   if ([[callbackDictionary objectForKey:@"email"] isEqualToString:_fieldEmail.text]) {
      //将自己退出modal视图
      [self dismissViewControllerAnimated:YES completion:nil];
   }
}



@end
