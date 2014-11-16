//
//  ZZZMeViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZMeViewController.h"
#import "ZZZWelcomeViewController.h"
#import "ZZZUserDefault.h"
#import "ZZZCutomMeTableViewCell.h"
#import "ZZZLogoutConnect.h"

@interface ZZZMeViewController ()

@end

@implementation ZZZMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.title = @"me";
       self.view.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1];
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
   
   // title “ME”
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_screenWidth-200)/2, 27, 200, 30)];
   titleLabel.text = @"ME";
   titleLabel.textColor = [UIColor whiteColor];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 18];
   titleLabel.textAlignment = UITextAlignmentCenter;
   [self.view addSubview:titleLabel];
   
   // 初始化me tableview的 dataSource
   NSString *currentAccount     = @"My account";
   NSString *logout             = @"Log off";
   NSString *suggestion         = @"Review";
   NSString *welcome            = @"Welcome";
   _meTableViewData = @[currentAccount, logout, suggestion, welcome];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   // 创建me页面的tableview
   static NSString *CellWithIdentifier = @"CellForMe";
   
   _meTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, _screenWidth, (_screenHeight-64-49))];
   [_meTableView setDelegate:self];
   [_meTableView setDataSource:self];
   [_meTableView setScrollEnabled:YES];
   
   [_meTableView registerClass:[ZZZCutomMeTableViewCell class] forCellReuseIdentifier:CellWithIdentifier];
   _meTableView.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1];
   _meTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线
   [self.view addSubview:_meTableView];
}

- (void)didReceiveMemoryWarning
{
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

-(void)createWelcomeModalView
{
   NSLog(@"createWelcomeModalView");
   
   //创建modal视图
   ZZZWelcomeViewController *welcomeVC = [[ZZZWelcomeViewController alloc] init];  //1
   [self presentViewController:welcomeVC animated:YES completion:Nil];   //2
   welcomeVC = nil;
}

-(void)logout
{
   NSLog(@"logout");
   
   // 退出登录
   ZZZUserDefault *def = [[ZZZUserDefault alloc] init];
   [def logoutUserDefaults];
   //def = nil;
   
   // 在服务器注销token
   ZZZLogoutConnect *logoutConnect = [[ZZZLogoutConnect alloc] init];
   [logoutConnect startConnect:[def readUserDefaults]];
   logoutConnect = nil;
   
   // 调起 welcomeView
   ZZZWelcomeViewController *welcomeVC = [[ZZZWelcomeViewController alloc] init];  //1
   [self presentViewController:welcomeVC animated:YES completion:Nil];   //2
   welcomeVC = nil;
}









/*
 * table view 方法
 *
 *
 *
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   //#warning Potentially incomplete method implementation.
   // Return the number of sections.
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //#warning Incomplete method implementation.
   // Return the number of rows in the section.
   int count = [self.meTableViewData count];
   return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellWithIdentifier = @"CellForMe";
   ZZZCutomMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
   
   // 创建数据cell
   if (cell == nil) {
      cell = [[ZZZCutomMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
   }
   NSUInteger row = [indexPath row];
   //cell.textLabel.text = [self.meTableViewData objectAtIndex:row];
   cell.contentView.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1];
   // 取消选中的背景色
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   //
   cell.cellTitleText = [self.meTableViewData objectAtIndex:row];
   
   return cell;
}


// 改变行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 56.5;
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   //  判断如果cell的文本是my account，则...
   if ([[self.meTableViewData objectAtIndex:indexPath.row] isEqualToString:@"My account"]) {
      NSString *text = [[[ZZZUserDefault alloc] init] readUserDefaults];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"My account" message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      [alert show];
   }
   
   //  判断如果cell的文本是logout，则...
   if ([[self.meTableViewData objectAtIndex:indexPath.row] isEqualToString:@"Log off"]) {
      [self logout];
   }
   
   //  判断如果cell的文本是...
   if ([[self.meTableViewData objectAtIndex:indexPath.row] isEqualToString:@"Review"]) {
      NSString *iTunesLink = @"https://itunes.apple.com/us/app/silent/id939406330?l=zh&ls=1&mt=8";
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
   }
   
   //  判断如果cell的文本是...
   if ([[self.meTableViewData objectAtIndex:indexPath.row] isEqualToString:@"Welcome"]) {
      NSString *text = @"Welcome to the SILENT. Here you face all your friends in real life with a mask. You talk to each other, but they don't know who you are. Is that fun? Enjoy it.";
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      [alert show];
   }
   
   /*
   NSUInteger row = [indexPath row];
   NSString *text = [self.meTableViewData objectAtIndex:row];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // 点击数据cell，弹提示
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"you click data cell" message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
   [alert show];
    */
}



@end
