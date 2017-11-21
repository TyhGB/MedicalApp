//
//  LoginViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "LoginViewController.h"
#import "OrganizationTableViewCell.h"
#import "PhoneNumberTableViewCell.h"
#import "PWDTableViewCell.h"
#import "RegistViewController.h"
#import "ForgetViewController.h"
#import "UserDataBase.h"
#import <SVProgressHUD.h>
#import "MainTabBarViewController.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) MainTabBarViewController *mainTabBarViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //标题
    self.title = @"用户登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    //navigation返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    //快速注册按钮
    UIBarButtonItem *registItem = [[UIBarButtonItem alloc]initWithTitle:@"快速注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist)];
    self.navigationItem.rightBarButtonItem = registItem;
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.forgetBtn];
    
}
-(void)regist
{
    RegistViewController *viewController = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
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
        OrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationID"];
        if (cell==nil) {
            cell = [[OrganizationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrganizationID"];
        }
        return cell;
    }
    else if(indexPath.section==1)
    {
        PhoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberID"];
        if (cell==nil) {
            cell = [[PhoneNumberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhoneNumberID"];
            //点击空白收回键盘
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.view addGestureRecognizer:tap];
            
        }
        return cell;
    }
    else
    {
        PWDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PWDTableViewCellID"];
        if (cell==nil) {
            cell = [[PWDTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PWDTableViewCellID"];
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
//跳转忘记密码
-(void)forgetPwd
{
    ForgetViewController *viewController = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - login
-(void)login
{
    // 根据Tag值,获取textField 手机
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    NSInteger phone =[textField.text integerValue];
    // 根据Tag值,获取textField 密码
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:101];
    NSString *pwd = textField2.text;
    if([[UserDataBase sharedUserDataBase]searchUser:phone])
    {
        if ([[UserDataBase sharedUserDataBase]matchPWD:pwd]) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            [SVProgressHUD dismissWithDelay:0.5];
            [self presentViewController:self.mainTabBarViewController animated:nil completion:nil];
            NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
            userDic = [[UserDataBase sharedUserDataBase] getUserInfo:[textField.text integerValue]];
            //通知传递用户信息到下一个界面的用户界面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInformation" object:nil userInfo:userDic];
            //1.发送通知名字 2.接收对象 3.发送通知信息
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"密码错误"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"用户不存在"];
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
-(UIButton *)loginBtn
{
    if (_loginBtn==nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //y坐标在tableview下面20
        _loginBtn.frame = CGRectMake(10, 64+20+150+20, self.view.frame.size.width-20, 50);
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        //背景紫色
        [_loginBtn setBackgroundColor:[UIColor purpleColor]];
        //设置圆角
        _loginBtn.layer.cornerRadius = 10;
        [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}
-(UIButton *)forgetBtn
{
    if (_forgetBtn==nil) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        //设置背景透明
        [_forgetBtn setBackgroundColor:[UIColor clearColor]];
        //设置位置在登陆按钮右下方
        _forgetBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-110, 64+20+150+20+20, 100, 100);
        [_forgetBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
-(MainTabBarViewController *)mainTabBarViewController
{
    if(_mainTabBarViewController==nil)
    {
        _mainTabBarViewController = [[MainTabBarViewController alloc]init];
    }
    return _mainTabBarViewController;
}
@end
