//
//  ViewController.m
//  AddressBook
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ViewController.h"
#import "ZZAddressBook.h"
#import "PersonModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ZZAddressBook *book;
}
@property (weak, nonatomic) IBOutlet UITableView *addressTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    book = [[ZZAddressBook alloc]init];
    book.getPersons = ^(NSMutableArray *persons){
        NSLog(@"persons == %@",persons);
        [self.addressTable reloadData];
    };
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return book.perArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    PersonModel *model = book.perArr[indexPath.row];
    if(model.firstName != nil){
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@  %@",model.lastName,model.firstName,model.phoneNumber];
    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",model.lastName,model.phoneNumber];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonModel *model = book.perArr[indexPath.row];
    [book sendMessageToBookFriendWithVC:self withModel:model];
    book.result = ^(enum MessageSendType result){
        if(result == 0){
            NSLog(@"用户取消发送");
        }else if (result == 1){
            NSLog(@"用户发送失败");
        }else if(result == 2){
            NSLog(@"用户消息发送成功");
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
