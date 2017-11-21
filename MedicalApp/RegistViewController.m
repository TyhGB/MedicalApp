//
//  RegistViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "RegistViewController.h"
#import "RphoneNumberTableViewCell.h"
#import "RuserNameTableViewCell.h"
#import "RpwdTableViewCell.h"
#import "UserDataBase.h"
#import "UserModel.h"
#import <SVProgressHUD.h>

@interface RegistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *loginBtn;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //标题
    self.title = @"快速注册";
    self.view.backgroundColor = [UIColor whiteColor];
    //navigation返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    
    [self.view addSubview:self.loginBtn];
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
        RphoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationID"];
        if (cell==nil) {
            cell = [[RphoneNumberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrganizationID"];
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
        }
        return cell;
    }
    else if(indexPath.section==1)
    {
        RuserNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberID"];
        if (cell==nil) {
            cell = [[RuserNameTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhoneNumberID"];
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
            
        }
        return cell;
    }
    else
    {
        RpwdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PWDTableViewCellID"];
        if (cell==nil) {
            cell = [[RpwdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PWDTableViewCellID"];
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
}
#pragma mark - regist
-(void)regist
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:101];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:102];
    BOOL result = [[UserDataBase sharedUserDataBase] searchUser:[textField.text integerValue]];
    if (result) {
        [SVProgressHUD showErrorWithStatus:@"用户名已存在"];
        [SVProgressHUD dismissWithDelay:0.5];
    }
    else
    {
        if (textField3.text.length>5) {
            //密码大于6位
            UserModel *model = [[UserModel alloc]init];
            model.phone = [textField.text integerValue];
            model.name = textField2.text;
            model.pwd = textField3.text;
            [[UserDataBase sharedUserDataBase] addUser:model];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [SVProgressHUD dismissWithDelay:0.5];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"密码过短"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
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
-(UIButton *)loginBtn
{
    if (_loginBtn==nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //y坐标在tableview下面20
        _loginBtn.frame = CGRectMake(10, 64+20+150+20, self.view.frame.size.width-20, 50);
        [_loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        //背景紫色
        [_loginBtn setBackgroundColor:[UIColor purpleColor]];
        //设置圆角
        _loginBtn.layer.cornerRadius = 10;
        //添加点击事件
        [_loginBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
    
}
@end
