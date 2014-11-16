//
//  ZZZSortAddressBook.m
//  Silent
//
//  Created by alfred on 14-11-12.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import "ZZZSortAddressBook.h"

@implementation ZZZSortAddressBook

-(NSMutableArray *)sortAddressBook:(NSMutableArray *)oldAddressBook
{
   /**
    * @brief 严版数据结构 选择排序
    *        采用"选择排序"对长度为n的数组进行排序,时间复杂度最好，最坏都是O(n^2)
    *        当最好的时候，交换次数为0次，比较次数为n(n-1)/2
    *        最差的时候，也就初始降序时，交换次数为n-1次，最终的排序时间是比较与交换的次数总和，
    *        总的时间复杂度依然为O(n^2)
    */
   //http://blog.csdn.net/hr10707020217/article/details/10581371
   
   NSInteger n = [oldAddressBook count];
   NSInteger i, j, index;
   id temp;
   NSMutableArray *newAddress = [oldAddressBook mutableCopy];
   
   for ( i = 0; i < n; ++i ) {
      index = i;
      for ( j = i + 1; j < n; ++j ) {
         //if ( R[index] > R[j] ) {
         if ([self firstCharCompare:[newAddress objectAtIndex:index] with:[newAddress objectAtIndex:j]]) {
            index = j;  //index中存放关键码最小记录的下标
         }
      }
      if (index != i) {
         temp = [newAddress objectAtIndex:i];
         [newAddress replaceObjectAtIndex:i withObject:[newAddress objectAtIndex:index]];
         [newAddress replaceObjectAtIndex:index withObject:temp];
      }
   }
   return newAddress;
}

-(BOOL)firstCharCompare:(id)ob1 with:(id)ob2
{
   NSArray *abcdefg = @[@"A",@"a",@"B",@"b",@"C",@"c",@"D",@"d",@"E",@"e",@"F",@"f",@"G",@"g",@"H",@"h",@"I",@"i",@"J",@"j",@"K",@"k",@"L",@"l",@"M",@"m",@"N",@"n",@"O",@"o",@"P",@"p",@"Q",@"q",@"R",@"r",@"S",@"s",@"T",@"t",@"U",@"u",@"V",@"v",@"W",@"w",@"X",@"x",@"Y",@"y",@"Z",@"z"];
   
   int int1 = 110, int2 = 120;
   for (int k=0; k < 26*2; k=k+1) {
      if ([[[ob1 objectForKey:@"name"] substringToIndex:1] isEqualToString:[abcdefg objectAtIndex:k]]) {
         int1 = k;
      }
      if ([[[ob2 objectForKey:@"name"] substringToIndex:1] isEqualToString:[abcdefg objectAtIndex:k]]) {
         int2 = k;
      }
   }
   //NSLog(@"%ld:%ld", (long)int1, (long)int2);
   if (int1 >= int2) {
      return YES;
   } else {
      return NO;
   }
   //-(NSString *) substringToIndex:i // 从开始一直到索引i的字符串
}

@end
