//
//  ZZAddressBook.h
//  AddressBook
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//
enum MessageSendType{
    
    MessageCancel = 0,
    MessageFailed,
    MessageSendSuccessed
    
}MessageSendType;

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
@class PersonModel;

typedef void (^PersonsBlock)(NSMutableArray *personArr);
typedef void (^ResultBlock)(enum MessageSendType result);

@interface ZZAddressBook : NSObject

- (void)sendMessageToBookFriendWithVC:(id)vc withModel:(PersonModel *)model;
@property (nonatomic,strong) ResultBlock result;


@property (nonatomic,strong) PersonsBlock getPersons;
@property (nonatomic,strong) NSMutableArray *perArr;


@end
