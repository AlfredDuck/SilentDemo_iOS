//
//  ZZZSortAddressBook.h
//  Silent
//
//  Created by alfred on 14-11-12.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZZSortAddressBook : NSObject

-(NSMutableArray *)sortAddressBook:(NSMutableArray *)oldAddressBook;
-(BOOL)firstCharCompare:(id)ob1 with:(id)ob2;

@end

