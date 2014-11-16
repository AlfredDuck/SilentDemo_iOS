//
//  ZZZMainViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZMainViewController.h"
#import "ZZZSilentViewController.h"
#import "ZZZFriendsViewController.h"
#import "ZZZMeViewController.h"

@interface ZZZMainViewController ()

@end

@implementation ZZZMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       [self.tabBar setHidden:YES];
    }
    return self;
}

-(void)loadSubVCs{
   ZZZSilentViewController *vc1 = [[ZZZSilentViewController alloc]init];
   UINavigationController *silentNav = [[UINavigationController alloc] initWithRootViewController:vc1];
   [silentNav setNavigationBarHidden:YES]; // vc3初始化的时候还没有navigaitionbar，所以要在这里控制navigationbar
   
   ZZZFriendsViewController *vc2 = [[ZZZFriendsViewController alloc]init];
   UINavigationController *friendsNav = [[UINavigationController alloc] initWithRootViewController:vc2];
   [friendsNav setNavigationBarHidden:YES]; // vc3初始化的时候还没有navigaitionbar，所以要在这里控制navigationbar
   
   ZZZMeViewController *vc3 = [[ZZZMeViewController alloc]init];
   UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:vc3];
   [meNav setNavigationBarHidden:YES]; // vc3初始化的时候还没有navigaitionbar，所以要在这里控制navigationbar
   
   //将这几个VC放入数组
   NSArray *viewControllers = @[silentNav, friendsNav, meNav];
   
   //数组添加到tabBarController
   //self 既是tabBarController
   //tabBarController.viewControllers  = viewControllers;
   [self setViewControllers:viewControllers animated:YES];
}

-(void)loadView
{
   [super loadView];
   [self loadSubVCs];
   [self createTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   //如果没有登录，则弹出登录模态页
   //
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Custom TabBar

-(void)createTabBar
{
   //自定义tabbar背景
   _screenHeight = [UIScreen mainScreen].bounds.size.height;
   _screenWidth = [UIScreen mainScreen].bounds.size.width;
   NSLog(@"screen size: %ld,%ld", (long)_screenHeight, (long)_screenWidth);
   
   UIView *customTabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, _screenHeight-49, _screenWidth, 49)];
   customTabBarView.backgroundColor = [UIColor colorWithRed:(58/255.0) green:(63/255.0) blue:(70/255.0) alpha:1]; //tab背景灰
   [self.view addSubview:customTabBarView];
   
   //自定义的tabbar响应触摸事件
   [customTabBarView isUserInteractionEnabled];
   
   // a line
   UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, 2)];
   line.backgroundColor = [UIColor colorWithRed:(18/255.0) green:(156/255.0) blue:(154/255.0) alpha:1];
   [customTabBarView addSubview:line];
   
   // 添加button的选中样式
   _selectedButton = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth/3.0, 8)];
   _selectedButton.backgroundColor = [UIColor colorWithRed:(18/255.0) green:(156/255.0) blue:(154/255.0) alpha:1];
   [customTabBarView addSubview:_selectedButton];
   
   //自定义tabBar按钮
   float add = 0;
   for (int index = 0; index<=2; index++) {
      UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(add, 0, _screenWidth/3.0, 49)];
      button.tag = index;
      
      switch (index) {
         case 0:
            [button setTitle:@"SILENT" forState:UIControlStateNormal];
            break;
         case 1:
            [button setTitle:@"FRIENDS" forState:UIControlStateNormal];
            break;
         case 2:
            [button setTitle:@"ME" forState:UIControlStateNormal];
            break;
         default:
            break;
      }
      
      button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
      button.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:0];
      [button addTarget:self action:@selector(clickBarButton:) forControlEvents:UIControlEventTouchUpInside];
      [customTabBarView addSubview:button];
      add = add + _screenWidth/3.0;
   }

}

-(void)clickBarButton:(UIButton *)button
{
   // 按照index选择哪个tab被选中（selected）
   self.selectedIndex = button.tag;
   // 选中的index button样式会变
   [_selectedButton setFrame:CGRectMake(_screenWidth*(button.tag)/3.0, 0, _screenWidth/3.0, 8)];
}

@end
