//
//  MeViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "MeViewController.h"
#import "SetAndHelpViewController.h"
#import "UserViewController.h"
#import "UserDataBase.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UserViewControllerDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSDictionary *userDic;
@property (nonatomic,strong) UIImage *headImage;
@end

@implementation MeViewController
-(instancetype)init
{
    self = [super init];
    if (self) {
        //接收通知，让接收者中name后面的参数和发送者中的name后面的参数一样。
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo:) name:@"userInformation" object:nil
         ];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0f/255.0 blue:245.0/255.0 alpha:1];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - notifcation function

-(void)getUserInfo:(NSNotification *)notifcation
{
    self.userDic = notifcation.userInfo;
}
#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return 4;
    }
    else
    {
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.00;
    }
    else
    {
        return 20.00;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100.f;
    }
    else
    {
        return 50.f;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //取消点击效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
//        cell.textLabel.text = @"用户名";
        cell.textLabel.text = [self.userDic valueForKey:@"name"];
        [cell.imageView.layer setCornerRadius:50];
        cell.imageView.layer.masksToBounds =YES;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.image = self.headImage;
        //固定cell.imageView.image的大小
        CGSize itemSize = CGSizeMake(100, 100);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else if (indexPath.section==1)
    {
        NSArray *array = @[@"账户充值",@"服务订单",@"健康档案",@"我的金币"];
        for (int i=0; i<array.count; i++) {
            if (indexPath.row==i) {
                cell.textLabel.text = array[i];
                cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            }
        }
    }
    else if (indexPath.section==2)
    {
        NSArray *array = @[@"设置与帮助",@"联系客服"];
        for (int i=0; i<array.count; i++) {
            if (indexPath.row==i) {
                cell.textLabel.text = array[i];
                cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0&&indexPath.row==0) {
        UserViewController * VC = [[UserViewController alloc]init];
        VC.phone = [self.userDic valueForKey:@"phone"];
        VC.nickName = [self.userDic valueForKey:@"name"];
        VC.delegate = self;
        VC.image = self.headImage;
        //跳转界面时 隐藏底部tabbar
//        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.section==2&&indexPath.row==0) {
        SetAndHelpViewController *viewController = [[SetAndHelpViewController alloc]init];
        //跳转到下级界面时 隐藏底部tabbar （显示本页面的时候显示底部tabbar在viewwillappear中设置）
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.section==2&&indexPath.row==1) {
        //联系客服cell
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"联系我们" message:@"手机号15850583035" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark - UserViewController delegate
-(void)changeName:(NSString *)name
{
    [self.userDic setValue:name forKey:@"name"];
    [self.tableView reloadData];
}
-(void)updateHead:(UIImage *)image
{
    self.headImage = image;
    [self.tableView reloadData];
}
#pragma mark - lazy load
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //将没有数据的cell置空
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSDictionary *)userDic
{
    if (_userDic==nil) {
        _userDic = [[NSDictionary alloc]init];
    }
    return _userDic;
}
-(UIImage *)headImage
{
    if (_headImage==nil) {
        _headImage = [[UIImage alloc]init];
        _headImage = [[UserDataBase sharedUserDataBase] getHeadPicture:[[self.userDic valueForKey:@"phone"] integerValue]];
    }
    return _headImage;
}
@end
