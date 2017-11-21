//
//  SetAndHelpViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SetAndHelpViewController.h"
#import "LoginViewController.h"
#import "ForgetViewController.h"

@interface SetAndHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton * button;
@end

@implementation SetAndHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"设置与帮助";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.button];
}
#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //取消点击效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        NSArray * array = [[NSArray alloc]initWithObjects:@"修改密码",@"帮助",@"声明", nil];
        cell.textLabel.text = array[indexPath.row];
    }
    else if(indexPath.section==1)
    {
        cell.textLabel.text = @"关于我们";
    }
    {
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        ForgetViewController *VC = [[ForgetViewController alloc]init];
        [self.navigationController pushViewController:VC
                                             animated:YES];
    }
}
#pragma mark - loginOut
//退出登陆
-(void)loginOut
{
    LoginViewController *VC = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - lazy load
-(UITableView *)tableView
{
    if (_tableView ==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //没有内容的cell显示空白
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
        //取消滚动
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
-(UIButton *)button
{
    if (_button==nil) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame =CGRectMake(10, 330,[UIScreen mainScreen].bounds.size.width-20 , 50);
        [_button setBackgroundColor:[UIColor purpleColor]];
        [_button setTitle:@"退出登陆" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];

    }
    return _button;
}
@end
