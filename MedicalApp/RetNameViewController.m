//
//  RetNameViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "RetNameViewController.h"
#import "UserDataBase.h"
#import <SVProgressHUD.h>

@interface RetNameViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation RetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    self.view.backgroundColor = [UIColor whiteColor];
    //完成按钮
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(resetName)];
    self.navigationItem.rightBarButtonItem = button;
    [self.view addSubview:self.tableView];

}
-(void)resetName
{
    [self.delegate changeName:self.textField.text];
    [[UserDataBase sharedUserDataBase] resetName:self.textField.text Phone:[_phone integerValue]];
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    [SVProgressHUD dismissWithDelay:1];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)configTextFieldText:(NSString *)name
{
    self.textField.text = name;
}
//点击空白收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

#pragma mark - tableView delegate and dataSourcce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    [view addSubview:self.label];
//    view.backgroundColor = [UIColor clearColor];
//    view.layer.borderWidth=1;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        [cell.contentView addSubview:self.textField];
    }
    return cell;
}

#pragma mark -lazy load
-(UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"6个汉字或者12个字母以内";
        _label.font = [UIFont systemFontOfSize:12.0];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor grayColor];
    }
    return _label;
}
-(UITextField *)textField
{
    if (_textField==nil) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _textField.clearButtonMode = YES;
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 164) style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}
@end
