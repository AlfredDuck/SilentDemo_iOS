//
//  ZZZFriendsViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZFriendsViewController.h"
#import "ZZZSendMessageViewController.h"
#import "ZZZAddressBook.h"
#import "ZZZUserDefault.h"
#import "ZZZCustomCellTableViewCell.h"
#import "ZZZURLManager.h"
#import "ZZZSortAddressBook.h"

@interface ZZZFriendsViewController ()
@end

@implementation ZZZFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
      self.title = @"friends";
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
   
   // title “FRIENDS”
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_screenWidth-200)/2, 27, 200, 30)];
   titleLabel.text = @"FRIENDS";
   titleLabel.textColor = [UIColor whiteColor];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 18];
   titleLabel.textAlignment = UITextAlignmentCenter;
   [self.view addSubview:titleLabel];
   
   // 通讯录无法获取的背景图
   UILabel *backgroudLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _screenHeight/2-30, _screenWidth-40, 50)];
   backgroudLabel.text = @"Can't Get Address Book";
   backgroudLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
   backgroudLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 16];
   backgroudLabel.textAlignment = UITextAlignmentCenter;
   [self.view addSubview:backgroudLabel];
   
   // refresh address book button
   UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(120, _screenHeight/2+15, _screenWidth-240, 20)];
   [refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
   refreshButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
   refreshButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
   [refreshButton addTarget:self action:@selector(clickRefreshButton) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview: refreshButton];
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self readAddressBook];
   NSLog(@"请求路径是：%@", [ZZZURLManager getHomePath]);
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

-(void)showAddressBook:(NSArray *)addressBook
{
   //NSLog(@"获取到的联系人：%@", addressBook);
   NSMutableArray *newAddressBook = [[NSMutableArray alloc] init];
   // 对获得的addressbook进行处理，除去残缺的联系人
   for (int i=0; i<[addressBook count]; i++) {
      if ([[addressBook objectAtIndex:i] objectForKey:@"name"] && [[addressBook objectAtIndex:i] objectForKey:@"cellphone"]) {
         [newAddressBook addObject:[addressBook objectAtIndex:i]];
      }
   }
   //NSLog(@"筛选后的联系人：%@", newAddressBook);
   
   //对联系人进行首字母排序
   ZZZSortAddressBook *sortAB =  [[ZZZSortAddressBook alloc] init];
   NSMutableArray *newAB = [sortAB sortAddressBook:newAddressBook];
   
   self.data = newAB;
   [self initFriendsTableView];   // 初始化tableView
}

-(void)readAddressBookFailAlert
{
   NSLog(@"readAddressBookFailAlert");
   // 获取失败，提示用户
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Get Address Book" message:@"please check it in 'setting-private'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
   [alert show];
}







/*
 * IBAction 方法
 *
 *
 *
 *
 */

-(void)clickRefreshButton
{
   NSLog(@"clickRefreshButton");
   [self readAddressBook];
}

-(void)clickTableViewCell:(int)row
{
   // 创建viewController
   ZZZSendMessageViewController *sendMessageVC = [[ZZZSendMessageViewController alloc] init];
   [self.navigationController pushViewController: sendMessageVC animated:YES];
   
   NSString *toWhomName = [[self.data objectAtIndex:row] objectForKey:@"name"];
   NSString *toWhomCellphone = [[self.data objectAtIndex:row] objectForKey:@"cellphone"];
   
   // 设置参数
   sendMessageVC.titleOfView = [@"to " stringByAppendingString:toWhomName];
   sendMessageVC.sendTo = toWhomCellphone;
   sendMessageVC.sendFrom = [[[ZZZUserDefault alloc] init] readUserDefaults];
   sendMessageVC = nil;

}








/*
 * FriendsViewController 私有方法
 * 1.读取通讯录
 * 2.初始化 table view
 *
 *
 *
 */

-(void)readAddressBook
{
   ZZZAddressBook *ab = [[ZZZAddressBook alloc] init];
   ab.delegate = self;  //代理授权
   [ab readAddressBook];
}

// 初始化 tableView
-(void)initFriendsTableView
{
   static NSString *CellWithIdentifier = @"CellForFriends";
   
   _friendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, _screenWidth, (_screenHeight-64-49))];
   [_friendsTableView setDelegate:self];
   [_friendsTableView setDataSource:self];
   
   [_friendsTableView registerClass:[ZZZCustomCellTableViewCell class] forCellReuseIdentifier:CellWithIdentifier];
   _friendsTableView.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1]; // 背景灰
   _friendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线
   
   [self.view addSubview:_friendsTableView];
}








/*
 * tableView 代理方法
 * ps.一切与tableView相关的方法在这里处理
 *
 *
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

// 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellWithIdentifier = @"CellForFriends";
   ZZZCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
   // my code:
   if (cell == nil) {
      cell = [[ZZZCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
   }
   /*
   NSUInteger row = [indexPath row];
   cell.textLabel.text = [[self.data objectAtIndex:row] objectForKey:@"name"];
   */
   
   NSUInteger row = [indexPath row];
   cell.contentView.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1]; //文本背景灰色
   // 取消选中的背景色
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   #pragma mark 直接往cell addsubView的方法会在每次划出屏幕再划回来时 再加载一次subview，因此会重复加载很多subview
   cell.name = [[self.data objectAtIndex:row] objectForKey:@"name"];
   
   return cell;
}

// 改变行高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 56.5;
}

// tableView 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSUInteger row = [indexPath row];
   [self clickTableViewCell:row];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
