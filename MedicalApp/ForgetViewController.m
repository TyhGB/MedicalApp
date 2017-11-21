//
//  ForgetViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ForgetViewController.h"
#import "FphoneNumberTableViewCell.h"
#import "FpwdTableViewCell.h"
#import "UserDataBase.h"
#import <SVProgressHUD.h>

@interface ForgetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
//提交按钮
@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //标题
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    //navigation返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FphoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationID"];
        if (cell==nil) {
            cell = [[FphoneNumberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrganizationID"];
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
        }
        return cell;
    }
    else if(indexPath.section==1)
    {
        FpwdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberID"];
        if (cell==nil) {
            cell = [[FpwdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhoneNumberID"];
            cell.label.text = @"设置密码";
            cell.textField.tag = 101;
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
            
            
        }
        return cell;
    }
    else
    {
        FpwdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PWDTableViewCellID"];
        if (cell==nil) {
            cell = [[FpwdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PWDTableViewCellID"];
            cell.label.text = @"确认密码";
            cell.textField.tag = 102;
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
        }
        return cell;
    }
    
}
-(void)tap
{
    // 根据Tag值,获取textField
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    [textField resignFirstResponder];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:101];
    [textField2 resignFirstResponder];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:102];
    [textField3 resignFirstResponder];
}
#pragma mark - submit
-(void)submit
{
    // 根据Tag值,获取textField
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    [textField resignFirstResponder];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:101];
    [textField2 resignFirstResponder];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:102];
    [textField3 resignFirstResponder];
    BOOL result = [[UserDataBase sharedUserDataBase] searchUser:[textField.text integerValue]];
    if (result) {
        //表示手机号存在
        if ([textField2.text isEqualToString:textField3.text]) {
            //表示两次密码一致
            if (textField2.text.length>5) {
                //表示密码长度大于6位
                [[UserDataBase sharedUserDataBase] resetPWD:textField2.text Phone:[textField.text integerValue]];
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                [SVProgressHUD dismissWithDelay:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"密码过短"];
                [SVProgressHUD dismissWithDelay:0.5];
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"手机号不存在"];
        [SVProgressHUD dismissWithDelay:0.5];
    }
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}
#pragma mark -lazy load
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+20, self.view.frame.size.width, 150) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor blueColor];
        //分割线
        //        _tableView.separatorColor = [UIColor grayColor];
        //禁止滑动
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(UIButton *)submitBtn
{
    if (_submitBtn==nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //y坐标在tableview下面20
        _submitBtn.frame = CGRectMake(10, 64+20+150+20, self.view.frame.size.width-20, 50);
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        //背景紫色
        [_submitBtn setBackgroundColor:[UIColor purpleColor]];
        //设置圆角
        _submitBtn.layer.cornerRadius = 10;
        //添加点击事件
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBtn;
    
}

@end
