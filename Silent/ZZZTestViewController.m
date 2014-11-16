//
//  ZZZTestViewController.m
//  Silent
//
//  Created by alfred on 14-10-7.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZTestViewController.h"
#import "ZZZGetMessages.h"
#import "ZZZMoreData.h"
/*
@interface ZZZTestViewController ()

@end

@implementation ZZZTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // Custom initialization
       self.title = @"test";
       self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   //执行get message请求
   NSString *cellphone = @"13864427782";
   ZZZGetMessages *getMessageConnect = [[ZZZGetMessages alloc] init];
   //  代理授权
   getMessageConnect.delegate = self;
   [getMessageConnect startConnect:cellphone skip:self.skip];
   getMessageConnect = nil;
   
   //创建一个导航栏按钮
   //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
   UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIBarButtonItemStyleDone  target:self action:@selector(loadMoreMessages)];
   self.navigationItem.rightBarButtonItem = refreshItem;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 实现代理方法
-(void)showMessages:(NSArray *)messages
{
   // 获得 tableView 数据
   self.listData = [messages mutableCopy]; //nsarray 向 nsmutablearray 复制需要用copy
   NSLog(@"%@", self.listData);
   
   // 初始化 tableView
   [self initMyTableView];
}

// 初始化 tableView
-(void)initMyTableView
{
   _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 420)];
   [_myTableView setDelegate:self];
   [_myTableView setDataSource:self];
   [_myTableView setScrollEnabled:YES];
   [self.view addSubview:_myTableView];
}

#pragma mark - Table view data source

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
   int count = [self.listData count];
   return count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellWithIdentifier = @"Cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
   UITableViewCell *loadMoreCell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];

   // 创建加载更多Cell
   if([indexPath row] == ([self.listData count])) {
      loadMoreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
      loadMoreCell.textLabel.text = @"load more";
      return loadMoreCell;
   }

   // 创建数据cell
   if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
   }
   NSUInteger row = [indexPath row];
   cell.textLabel.text = [[self.listData objectAtIndex:row] objectForKey:@"text"];
   cell.detailTextLabel.text = @"详细信息";
   return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row == [self.listData count]) {
//      UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath];
//      loadMoreCell.textLabel.text=@"正在读取更信息 …";
//      [self performSelectorInBackground:@selector(loadMoreMessages) withObject:nil];
//      [tableView deselectRowAtIndexPath:indexPath animated:YES];
      [self loadMoreMessages];
      return;
   }
   
   NSUInteger row = [indexPath row];
   NSString *text = [[self.listData objectAtIndex:row] objectForKey:@"text"];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // 点击数据cell，弹提示狂
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"you click data cell" message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
   [alert show];
}

-(void)loadMoreMessages
{
   NSLog(@"load more messages");
//   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"you click load more cell" message:@"load more messages" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//   [alert show];
   
   // 准备一些加载的假数据 newData
//   NSMutableArray *newData =  [NSMutableArray array];
//   NSDictionary *d1 = [NSDictionary dictionaryWithObjectsAndKeys:@"fuck fuck fuck",@"text",nil];
//   NSDictionary *d2 = [NSDictionary dictionaryWithObjectsAndKeys:@"dick dick dick",@"text",nil];
//   [newData addObject:d1];
//   [newData addObject:d2];
//   NSLog(@"%@", newData);
   
   //
   ZZZMoreData *moreData = [[ZZZMoreData alloc] init];
   [moreData startConnect:@"13864427782" skip:3];
   moreData.delegate = self;
}

-(void)addMoreMessages:(NSArray *)messages
{
   
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
   [_myTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
   //最后一步在之前遇到了难解的bug，后来发现是newData的假数据是for循环制造的重复数据造成的bug，在 stack over flow上得到了解决。thanks
   
}

@end
*/