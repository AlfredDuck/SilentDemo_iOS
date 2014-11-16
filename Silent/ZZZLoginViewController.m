//
//  ZZZLoginViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZLoginViewController.h"
#import "ZZZLoginConnect.h"
#import "ZZZUserDefault.h"

@interface ZZZLoginViewController ()

@end

@implementation ZZZLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.title = @"login";
       self.view.backgroundColor = [UIColor colorWithRed:(57/255.0) green:(201/255.0) blue:(183/255.0) alpha:1];
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
   
   // title
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 44)];
   titleLabel.text = @"LOG IN";
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
   UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]; // 设置手势
   [closeImageView addGestureRecognizer:singleTap]; // 给图片添加手势
   [self.view addSubview:closeImageView];
   
   
   UIView *blackView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 74, _screenWidth-20, 54)];
   blackView1.backgroundColor  = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   [self.view addSubview:blackView1];
   
   UIView *blackView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 74+64, _screenWidth-20, 55)];
   blackView2.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   [self.view addSubview:blackView2];
   
   //cellphone textfield
   _fieldCellphone = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, _screenWidth-20-15, 54)];
   [_fieldCellphone setBorderStyle:UITextBorderStyleNone]; //外框类型
   _fieldCellphone.placeholder = @"PHONE NUMBER"; //默认显示的字
   _fieldCellphone.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   _fieldCellphone.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   _fieldCellphone.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   [blackView1 addSubview:_fieldCellphone];
   
   //password textfield
   _fieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, _screenWidth-20-15, 54)];
   [_fieldPassword setBorderStyle:UITextBorderStyleNone]; //外框类型
   _fieldPassword.placeholder = @"PASSWORD"; //默认显示的字
   _fieldPassword.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   _fieldPassword.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   _fieldPassword.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   [blackView2 addSubview:_fieldPassword];
   
   // 设置placeholder的文本和颜色
   if ([_fieldCellphone respondsToSelector:@selector(setAttributedPlaceholder:)]) {
      UIColor *color = [UIColor lightGrayColor];
      _fieldCellphone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PHONE NUMBER" attributes:@{NSForegroundColorAttributeName: color}];
      _fieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];
   } else {
      NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
      // TODO: Add fall-back code to set placeholder color.
   }
   
   
   //login button
   UIButton *loginButton= [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth-110, 74+64+64, 310, 44)];
   loginButton.backgroundColor = [UIColor colorWithRed:(13/255.0) green:(172/255.0) blue:(170/255.0) alpha:1];
   loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
   [loginButton setTitle:@"   GO ON" forState:UIControlStateNormal];
   [loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: loginButton];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
 * 实现代理方法
 *
 *
 *
 *
 */

-(void)loginConnectDelegate:(NSDictionary *)json
{
   if ([[json objectForKey:@"success"] isEqualToString:@"yes"]) {
      
      NSLog(@"登录成功");
      // 储存登录信息到 userDefaults
      NSArray *loginInfo = [NSArray arrayWithObjects:[json objectForKey:@"cellphone"], nil];
      ZZZUserDefault *userD = [[ZZZUserDefault alloc] init];
      [userD saveUserDefaults:loginInfo];
      
      [self dismissViewControllerAnimated:YES completion:nil];  //将自己退出modal视图
      
   } else {
      
      NSLog(@"登录失败");
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:@"the phone num or password is wrong" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      [alert show];
   }
   
}






/*
 * 实现IBAction方法
 *
 *
 *
 *
 */

-(void)clickLoginButton
{
   NSLog(@"clickLoginButton");

   // 准备登录物料
   NSString *cellphone = _fieldCellphone.text;
   NSString *password = _fieldPassword.text;
   
   if ([cellphone isEqualToString:@""]){
      NSLog(@"手机号是空的");
      return;
   }
   if ([password isEqualToString:@""]){
      NSLog(@"密码是空的");
      return;
   }

   //NSLog(@"是否能执行到这里？");
   
   // 登录时要同时上传设备token
   ZZZUserDefault *userDef = [[ZZZUserDefault alloc] init];
   NSString *deviceToken = nil;
   if ([userDef readDeviceToken]) {
      deviceToken = [userDef readDeviceToken];
   }
   else {
      //deviceToken = @"1111";
      deviceToken = @"no device token";
   }
   
   
   // 执行登录请求
   ZZZLoginConnect *loginConnect = [[ZZZLoginConnect alloc] init];
   loginConnect.delegate = self;   // 代理授权
   [loginConnect startConnect:cellphone password:password deviceToken:deviceToken];
   loginConnect = nil;
   
}

-(void)goBack
{
   NSLog(@"goBack");
   //将自己退出modal视图
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
