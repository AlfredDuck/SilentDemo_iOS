//
//  ZZZWelcomeViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZWelcomeViewController.h"
#import "ZZZLoginViewController.h"
#import "ZZZSignupViewController.h"
#import "ZZZUserDefault.h"

@interface ZZZWelcomeViewController ()

@end

@implementation ZZZWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 200, 50)];
   titleLabel.text = @"SILENT";
   titleLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 32];
   [self.view addSubview:titleLabel];
   
   int highOfLabels = 147;
   
   // introduce
   UILabel *introduceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, highOfLabels, 200, 50)];
   introduceLabel1.text = @"SEND";
   introduceLabel1.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   introduceLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size: 12];
   [self.view addSubview:introduceLabel1];
   
   UILabel *introduceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, (highOfLabels + 15), 200, 50)];
   introduceLabel2.text = @"ANONYMOUS MESSAGES";
   introduceLabel2.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   introduceLabel2.font = [UIFont fontWithName:@"Helvetica" size: 12];
   [self.view addSubview:introduceLabel2];
   
   UILabel *introduceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20, (highOfLabels + 30), 200, 50)];
   introduceLabel3.text = @"TO";
   introduceLabel3.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   introduceLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size: 12];
   [self.view addSubview:introduceLabel3];
   
   UILabel *introduceLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, (highOfLabels + 45), 200, 50)];
   introduceLabel4.text = @"YOUR FRIENDS";
   introduceLabel4.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   introduceLabel4.font = [UIFont fontWithName:@"Helvetica" size: 12];
   [self.view addSubview:introduceLabel4];
   
   /*
    两个按钮的高度分别是54，间距是10，按钮顶部距离屏幕底部200
    */
   
   //to loginView button
   UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, _screenHeight-200, _screenWidth-20, 54)];
   loginButton.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   [loginButton setTitle:@"    CREATE AN ACCOUNT" forState:UIControlStateNormal];
   loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 设置水平居左
   loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   [loginButton addTarget:self action:@selector(modalSignup) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: loginButton];
   
   //to SignupView button
   UIButton *signupButton = [[UIButton alloc] initWithFrame:CGRectMake(20, (_screenHeight-200+64), _screenWidth-20, 54)];
   signupButton.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   signupButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   signupButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   [signupButton setTitle:@"    I HAVE AN ACCOUNT" forState:UIControlStateNormal];
   [signupButton addTarget:self action:@selector(modalLogin) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: signupButton];
   
   //back button(调试阶段需要)
   /*
   UIButton *getBackButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 240, 280, 20)];
   getBackButton.backgroundColor = [UIColor redColor];
   [getBackButton setTitle:@"back" forState:UIControlStateNormal];
   [getBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: getBackButton];
   */
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
   // 检查是否登录,如果已经登录则自动退出此页面
   ZZZUserDefault *userd = [[ZZZUserDefault alloc] init];
   if ([[userd inOrOutUserDefaults] isEqualToString:@"in"]) {
      NSLog(@"打印登录信息： %@", [userd inOrOutUserDefaults]);
      //将自己退出modal视图
      [self dismissViewControllerAnimated:YES completion:nil];
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)modalLogin
{
   NSLog(@"modalLogin");
   
   // 创建modal视图
   ZZZLoginViewController *loginVC = [[ZZZLoginViewController alloc] init];  //1
   [self presentViewController:loginVC animated:YES completion:Nil];   //2
   loginVC = nil;
   
   // 检查是否登录
   ZZZUserDefault *userd = [[ZZZUserDefault alloc] init];
   NSLog(@"打印登录信息： %@", [userd readUserDefaults]);
   
}

-(void)modalSignup
{
   NSLog(@"modalSignup");
   
   //创建modal视图
   ZZZSignupViewController *signupVC = [[ZZZSignupViewController alloc] init];  //1
   [self presentViewController:signupVC animated:YES completion:Nil];   //2
   signupVC = nil;
}

-(void)goBack
{
   NSLog(@"goBack");
   //将自己退出modal视图
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
