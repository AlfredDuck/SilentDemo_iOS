//
//  ZZZSilentViewController.m
//  Silent
//
//  Created by alfred on 14-10-1.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZSilentViewController.h"
#import "ZZZAddressBook.h"
#import "ZZZGetMessages.h"
#import "ZZZUserDefault.h"
#import "ZZZWelcomeViewController.h"
#import "ZZZTestViewController.h"
#import "ZZZSendMessageViewController.h"
#import "ZZZCustomSilentTableViewCell.h"

@interface ZZZSilentViewController ()

@end

@implementation ZZZSilentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
      self.title = @"Silent";
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
   
   // title “SILENT”
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_screenWidth-200)/2, 27, 200, 30)];
   titleLabel.text = @"SILENT";
   titleLabel.textColor = [UIColor whiteColor];
   titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 18];
   titleLabel.textAlignment = UITextAlignmentCenter;
   [self.view addSubview:titleLabel];
   
   // 初始化小菊花
   _loadingButton = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
   //loadingButton.center = self.view.center;
   _loadingButton.frame = CGRectMake(_screenWidth-50, 17, 50, 50);
   [_loadingButton startAnimating];
   //[loadingButton stopAnimating];
   [self.view addSubview:_loadingButton];
   
   // refresh button pic
   UIImage *oneImage = [UIImage imageNamed:@"Refresh_button.png"]; // 使用ImageView通过name找到图片
   _refreshImageView = [[UIImageView alloc] initWithImage:oneImage]; // 把oneImage添加到oneImageView上
   _refreshImageView.frame = CGRectMake(_screenWidth-46, 20, 44, 44); // 设置图片位置和大小
   // 为图片添加点击事件
   // 一定要先将userInteractionEnabled置为YES，这样才能响应单击事件
   _refreshImageView.userInteractionEnabled = YES; // 设置图片可以交互
   UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRefreshButton)]; // 设置手势
   [_refreshImageView addGestureRecognizer:singleTap]; // 给图片添加手势
   [self.view addSubview:_refreshImageView];
   
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   // 初始化 分页计数和分页步数
   self.pullSkip = 0;
   self.pullStep = 20;
   [self pullMessage];
   
   // 监听从 sendMessageVC 传来的消息
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickRefreshButton) name:@"RefreshSilent" object:nil];
   
   _refreshImageView.alpha = 0;  // 开启app，loading数据时，刷新按钮隐藏
   // 开始计时,10s
   _timerRefresh = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFiredRefresh) userInfo:nil repeats:NO];
 
}

-(void)timerFiredRefresh
{
   [_timerRefresh invalidate];
   _refreshImageView.alpha = 1.0;
   [_loadingButton stopAnimating];
}


-(void)viewDidAppear:(BOOL)animated
{
   // 检查是否登录，如果未登录，则调起welcome页面
   ZZZUserDefault *userd = [[ZZZUserDefault alloc] init];
   if ([[userd inOrOutUserDefaults] isEqualToString:@"in"]) {
      NSLog(@"打印登录信息： %@", [userd readUserDefaults]);
   }
   else {
      //创建modal视图
      ZZZWelcomeViewController *welcomeVC = [[ZZZWelcomeViewController alloc] init];  //1
      [self presentViewController:welcomeVC animated:YES completion:Nil];   //2
      welcomeVC = nil;
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
















/*
 * 私有方法 SilentViewController
 *
 *
 *
 *
 */

// 开启客户端时，拉取message
-(void)pullMessage
{
   NSString *cellphone = nil;
   if ([[[ZZZUserDefault alloc] init] readUserDefaults]) {
      cellphone = [[[ZZZUserDefault alloc] init] readUserDefaults];
   } else {
      cellphone = @"0000000000";
   }
   ZZZGetMessages *getMessageConnect = [[ZZZGetMessages alloc] init];
   getMessageConnect.delegate = self;  //代理授权
   [getMessageConnect startConnect:cellphone skip:_pullSkip];
   
   //skip自增应该再成功返回数据以后，所以...
   //_pullSkip = _pullSkip + _pullStep;
}

// 初始化 tableView
-(void)initSilentTableView
{
   static NSString *CellWithIdentifier = @"CellForSilent";
   
   _silentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, _screenWidth, (_screenHeight-64-49))];
   [_silentTableView setDelegate:self];
   [_silentTableView setDataSource:self];
   
   [_silentTableView registerClass:[ZZZCustomSilentTableViewCell class] forCellReuseIdentifier:CellWithIdentifier];
   _silentTableView.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1]; // 背景灰
   _silentTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线
   [self.view addSubview:_silentTableView];
}


//
-(void)showMessages:(NSArray *)callBackMessages
{
   [_loadingButton stopAnimating];  // 一旦数据返回，则小菊花消失
   _refreshImageView.alpha = 1.0;  // 数据返回后，刷新按钮再出现
   self.listData = [callBackMessages mutableCopy];  // 获得 tableView 数据
   
   if ([self.listData count] == 0) {
      NSLog(@"message is empty");
      
//      // 为空提示
//      _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake((_screenWidth-200)/2.0, _screenHeight/2.0-50, 200, 50)];
//      _emptyLabel.text = @"You can start now";
//      _emptyLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
//      _emptyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 15];
//      _emptyLabel.textAlignment = UITextAlignmentCenter;
//      [self.view addSubview:_emptyLabel];
   }
   
   //NSLog(@"%@", [self.listData objectAtIndex:0]);
   if ([self.listData count] == 1 && [[[self.listData objectAtIndex:0] objectForKey:@"text"]isEqualToString:@":::err:::"]) {
      // 出错提示
      UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_screenWidth-200)/2.0, _screenHeight/2.0-50, 200, 50)];
      titleLabel.text = @"Try to refresh";
      titleLabel.textColor = [UIColor colorWithRed:(243/255.0) green:(243/255.0) blue:(243/255.0) alpha:1];
      titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 15];
      titleLabel.textAlignment = UITextAlignmentCenter;
      [self.view addSubview:titleLabel];
   }
   
   // 首次加载tableview 和 刷新tableview都会调用showMessages，所以要分别处理
   if (_silentTableView == nil && [self.listData count] != 0){
      [self initSilentTableView];  // 初始化tableview
   }
   else {
      [_silentTableView reloadData];  // 重载数据
   }
}

//
-(void)addMoreMessages:(NSArray *)messages
{
   // 若取得的message为空
   if ([messages count] == 0){
      NSLog(@"No more messages");
      NSIndexPath *thePAth =[NSIndexPath indexPathForRow:[self.listData count] inSection:0];
      [_silentTableView cellForRowAtIndexPath: thePAth].textLabel.text = @"No More";  // 改写最后一个cell
   }

   // 加载的数据填充到整体数据上
   for (int i=0;i<[messages count];i++) {
      [self.listData addObject:[messages objectAtIndex:i]];
   }
   
   //添加新的cell
   NSMutableArray *insertIndexPaths =  [NSMutableArray array];
   for (int ind = 0; ind < ([messages count]); ind++) {
      
      NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[self.listData indexOfObject:[messages objectAtIndex:ind]] inSection:0];
      [insertIndexPaths addObject:newPath];
   }
   [_silentTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
   //最后一步在之前遇到了难解的bug，后来发现是newData的假数据是for循环制造的重复数据造成的bug，在 stack over flow上得到了解决。thanks
}












/*
 * 实现代理方法
 *
 *
 *
 *
 */

-(void)messageConnectDelegate:(NSArray *)messages
{
   // 判断是不是第一次请求（如果是，则skip应该是0）
   if (_pullSkip == 0) {
      [self showMessages:messages];
      [_silentTableView setContentOffset:CGPointMake(0, 0) animated:YES];  // refresh以后回到列表顶部
   }
   else{
      [self addMoreMessages:messages];
   }
   
   /*
    * 数据正确返回后，再自增skip，但是如果返回的数据是空数组，则不应该自增。
    * 在压力测试时，返回空数组的概率很高。
    */
   if ([messages count] != 0) {
      _pullSkip = _pullSkip + _pullStep;
   }
}

// 在 ZZZSendMessageViewController.m 中调用此代理方法
/*
-(void)addSendedMessageToList:(NSDictionary *)newMessage
{
   // add new data to the data source
   NSLog(@"add new Message: %@", [newMessage objectForKey:@"text"]);
   [_listData insertObject:newMessage atIndex:0];
   
   // reload the table view
   [_silentTableView reloadData];
}
*/









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
   _pullSkip = 0; // skip清零
   [self pullMessage];
   
   // 点刷新按钮，loading数据时，刷新按钮隐藏
   _refreshImageView.alpha = 0;
   [_loadingButton startAnimating];
   
   // 开始计时,10s
   _timerRefresh = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFiredRefresh) userInfo:nil repeats:NO];
}

/*
 *上面实现过一次这个方法了
-(void)timerFiredRefresh
{
   [_timerRefresh invalidate];
   _refreshImageView.alpha = 1.0;
   [_loadingButton stopAnimating];
}
*/

-(void)clickTableViewCell:(int)row
{
   // 普通cell的动作方法，进入reply页面
   ZZZSendMessageViewController *sendMessageVC = [[ZZZSendMessageViewController alloc] init];
   //sendMessageVC.delegate = self;
   [self.navigationController pushViewController: sendMessageVC animated:YES];
   
   NSString *toWhomCellphone = [[self.listData objectAtIndex:row] objectForKey:@"from"];
   NSString *reply = [[self.listData objectAtIndex:row] objectForKey:@"text"];
   
   sendMessageVC.titleOfView = @"Reply";
   sendMessageVC.sendTo = toWhomCellphone;
   sendMessageVC.sendFrom = [[[ZZZUserDefault alloc] init] readUserDefaults];
   
   if (reply.length > 20) {
      sendMessageVC.withReply = [[reply substringToIndex:20] stringByAppendingString:@"..."]; // 只截取回复内容的一段
   } else {
      sendMessageVC.withReply = reply;
   }
   
   sendMessageVC = nil;
}










/*
 * tableView方法
 *
 *
 *
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
   // 当加载数据不少于一个step的时候才显示more cell
   int count = [self.listData count];
   if (count >= self.pullStep) {
      return count + 1;
   }
   else {
      return count;
   }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellWithIdentifier = @"CellForSilent";
   // 每一个cell使用不同的标示符号，这样可以禁用cell重用
   NSString *CellIdentifier2222 = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
   
   UITableViewCell *loadMoreCell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
   ZZZCustomSilentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2222];
   
   // 创建 loadMoreCell（当加载数据不少于一个step的时候才显示more cell）
   if ([self.listData count] >= self.pullStep) {
      if([indexPath row] == ([self.listData count])) {
         loadMoreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
         loadMoreCell.textLabel.text = @"More";
         loadMoreCell.textLabel.textColor = [UIColor whiteColor];
         loadMoreCell.textLabel.textAlignment = UITextAlignmentCenter;
         loadMoreCell.contentView.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(80/255.0) blue:(90/255.0) alpha:1];
         // 取消选中的背景色
         loadMoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
         
         return loadMoreCell;
      }
   }
   
   // 创建普通cell
   if (cell == nil) {
      cell = [[ZZZCustomSilentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2222];
   }
   
   NSUInteger row = [indexPath row];
   //cell.textLabel.text = [[_listData objectAtIndex:row] objectForKey:@"text"];
   cell.contentView.backgroundColor = [UIColor colorWithRed:(63/255.0) green:(70/255.0) blue:(78/255.0) alpha:1]; //文本背景灰色
   // 取消选中的背景色
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   cell.cellMessageText = [[_listData objectAtIndex:row] objectForKey:@"text"];
   // 卧槽，上面这句有个不容易复现的bug！！！！貌似是cell重用机制的问题，通过让每个cell使用不同标示符，禁用了cell重用机制
   
   return cell;
}


// 动态改变行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // loadMoreCell 要特殊处理
   if([indexPath row] == ([self.listData count])) {
      return 40;
   }
   
   NSUInteger row = [indexPath row];
   NSString *str = [[_listData objectAtIndex:row] objectForKey:@"text"];
   CGSize maxSize = {_screenWidth-20-20, 5000};
   // 设置文本可折行
   CGSize labelSize = [str sizeWithFont:[UIFont boldSystemFontOfSize:16]
                      constrainedToSize:maxSize
                          lineBreakMode:_messageLabel.lineBreakMode];   // str是要显示的字符串
   return labelSize.height + 35;
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // 判断是不是loadMoreCell（最后一个cell）
   if (indexPath.row == [self.listData count]) {
      if ([[_silentTableView cellForRowAtIndexPath: indexPath].textLabel.text isEqualToString:@"Loading..."]) {
         // 如果正在loading，则不响应点击事件
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
         return;
      } else {
         [self pullMessage];
         //NSIndexPath *thePAth =[NSIndexPath indexPathForRow:[self.listData count] inSection:0];
         [_silentTableView cellForRowAtIndexPath: indexPath].textLabel.text = @"Loading...";  // 改写最后一个cell
         
         // 开始计时,10s
         _timerAddMore = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFiredAddMore) userInfo:nil repeats:NO];
         
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
         return;
      }
   }
   
   NSUInteger row = [indexPath row];
   [self clickTableViewCell:row];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   return;
}

-(void)timerFiredAddMore
{
   NSIndexPath *thePAth =[NSIndexPath indexPathForRow:[self.listData count] inSection:0];
   [_silentTableView cellForRowAtIndexPath: thePAth].textLabel.text = @"More";  // 改写最后一个cell
}

@end
