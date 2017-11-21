//
//  UserViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "UserViewController.h"
#import "HeadTableViewCell.h"
#import "NickNameTableViewCell.h"
#import "UserPhoneTableViewCell.h"
#import "CardTableViewCell.h"
#import "RetNameViewController.h"
#import "SetHeadViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,RetNameViewControllerDelegate,SetHeadViewControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}
#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 101.00;
    }
    else
    {
        return 51.00;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.00;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[HeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellZero"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configHeadView:_image];
        }
        return cell;
    }
    else if (indexPath.row==1)
    {
        NickNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[NickNameTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell configNickName:_nickName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row==2)
    {
        UserPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[UserPhoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
            [cell configPhone:_phone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else
    {
        CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[CardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThree"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        SetHeadViewController * VC = [[SetHeadViewController alloc]init];
        VC.phone = [_phone integerValue];
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row==1) {
        RetNameViewController *VC = [[RetNameViewController alloc]init];
        VC.phone = _phone;
        VC.delegate = self;
        [VC configTextFieldText:_nickName];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark - retName delegate
-(void)changeName:(NSString *)name
{
    self.nickName = name;
    //UserViewController的代理 更新上一级
    [self.delegate changeName:name];
    [self.tableView reloadData];
}
#pragma mark - setHeadViewDelegate
-(void)updateHead:(UIImage *)image
{
    _image = image;
    //UserViewController的代理 更新上一级
    [self.delegate updateHead:image];
    [self.tableView reloadData];
}
#pragma mark -lazy load
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}



@end
