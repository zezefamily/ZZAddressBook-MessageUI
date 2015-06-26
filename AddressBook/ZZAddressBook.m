//
//  ZZAddressBook.m
//  AddressBook
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ZZAddressBook.h"
#import "PersonModel.h"
@interface ZZAddressBook ()<MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *_addressArr;
    NSMutableArray *_persons;
    UIViewController *_vc;
}
@end
@implementation ZZAddressBook
- (instancetype)init
{
    self = [super init];
    if(self){
        _addressArr = [[NSArray alloc]init];
        _persons = [[NSMutableArray alloc]init];
        [self getAlladdressBook];
    }
    return self;
}
- (void)getAlladdressBook
{
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if(granted){
//            查询所有
            _addressArr = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
            [self cleanDataWithArr:_addressArr];
//            按照条件查找
            
        }else{
            NSLog(@"拒绝授权");
        }
        
        
        
    });
}

- (void)cleanDataWithArr:(NSArray *)arr
{
    for(int i = 0;i<arr.count;i++){
        
        ABRecordRef ref = (__bridge ABRecordRef)(arr[i]);
        
//        获取每个人Person的phoneNumber数据集
        ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(ref, kABPersonPhoneProperty);
        NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
        
        PersonModel *model = [[PersonModel alloc]init];
        model.firstName = CFBridgingRelease(ABRecordCopyValue(ref, kABPersonFirstNameProperty));
        model.lastName = CFBridgingRelease(ABRecordCopyValue(ref, kABPersonLastNameProperty));
        model.phoneNumber = phoneNumberArray[0];
        [_persons addObject:model];
        
    }
    self.perArr = _persons;
    self.getPersons(_persons);
}



- (void)sendMessageToBookFriendWithVC:(id)vc withModel:(PersonModel *)model
{
    _vc = vc;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if(messageClass != nil){
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
        messageVC.messageComposeDelegate = self;
        messageVC.body = [NSString stringWithFormat:@"小伙伴！您的好友邀请你Ballersup对决!还等什么？赶快加入吧！http://www.ballersup.com(测试)"];
        messageVC.recipients = @[model.phoneNumber];
        [vc presentViewController:messageVC animated:YES completion:nil];
        
    }else {
//        Have error here ...
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    enum MessageSendType type;
    switch (result){
            case MessageComposeResultCancelled:
            type = 0;
            break;
            case MessageComposeResultFailed:
            type = 1;
            break;
            case MessageComposeResultSent:
            type = 2;
            break;
            default:
            break;
    }
    self.result(type);
}




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
