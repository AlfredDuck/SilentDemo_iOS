//
//  ZZZAddressBook.h
//  Silent
//
//  Created by alfred on 14-10-2.
//  Copyright (c) 2014年 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@protocol showAddressBook <NSObject>
@required
-(void)showAddressBook: (NSArray *)addressBook;
@optional
-(void)readAddressBookFailAlert;
@end


@interface ZZZAddressBook : NSObject
@property(nonatomic, strong) NSMutableArray *myFriends;
@property(nonatomic, assign) id <showAddressBook> delegate;
-(void)readAddressBook;
@end
