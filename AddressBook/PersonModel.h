//
//  PersonModel.h
//  AddressBook
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic,copy) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSString *phoneNumber;


/*
 
 kABPersonFirstNameProperty，名字
 
 kABPersonLastNameProperty，姓氏
 
 kABPersonMiddleNameProperty，中间名
 
 kABPersonPrefixProperty，前缀
 
 kABPersonSuffixProperty，后缀
 
 kABPersonNicknameProperty，昵称
 
 kABPersonFirstNamePhoneticProperty，名字汉语拼音或音标
 
 kABPersonLastNamePhoneticProperty，姓氏汉语拼音或音标
 
 kABPersonMiddleNamePhoneticProperty，中间名汉语拼音或音标
 
 kABPersonOrganizationProperty，组织名
 
 kABPersonJobTitleProperty，头衔
 
 kABPersonDepartmentProperty，部门
 
 kABPersonNoteProperty，备注
 */


@end
