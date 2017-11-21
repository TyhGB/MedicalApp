//
//  IndexViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "IndexViewController.h"
#import "SectionOneTableViewCell.h"
#import "SectionTwoTableViewCell.h"
#import "SectionZeroTableViewCell.h"
#import "AFNetworking.h"
#import "IndexDataModel.h"
#import "MJRefresh.h"
#import "SectionTwoHeader.h"
#import "TYH_WebViewController.h"

// buttons click
#import "AskDoctorsViewController.h"
#import "AppointmentViewController.h"
#import "WisdomMedicalViewController.h"
#import "ReportViewController.h"
#import "HealthTestViewController.h"
#import "CreditShopViewController.h"
#import "TYH_WebViewController.h"
@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView; //数据列表
@property (nonatomic,strong) NSMutableArray * indexDataArray;//数据
@property (nonatomic,strong) IndexDataModel * indexDataModel;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0f/255.0 blue:245.0/255.0 alpha:1];
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegatAndDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 1;
    }
    else
    {
        return self.indexDataArray.count;
    }
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
        return 150;
    }
    else if (indexPath.row==0&&indexPath.section==1) {
        return 160;
    }
    else
    {
        return 100;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 50;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYH_WebViewController * listInfo = [[TYH_WebViewController alloc] init];
    IndexDataModel * dataModel = self.indexDataArray[indexPath.row];
    NSString *url = @"https://oneitfarm.com/cms/";
    url = [url stringByAppendingString:dataModel.link];
    listInfo.url = url;
    listInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listInfo animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        SectionTwoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"tuijian"];
        if (header==nil) {
            header = [[SectionTwoHeader alloc]initWithReuseIdentifier:@"tuijian"];
        }
        [header.moreBtn addTarget:self action:@selector(clikMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
//点击更多按钮
-(void)clikMoreBtn
{
    
    [self.tabBarController setSelectedIndex:2];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        SectionZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zeroCellID"];
        if (cell==nil) {
            cell = [SectionZeroTableViewCell alloc];
            cell.cellFrame = [tableView rectForRowAtIndexPath:indexPath];
            cell.indexViewController = self;
            cell=[cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zeroCellID"];
        }
        return cell;
    }
    else if(indexPath.section==1)
    {
        SectionOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCellID"];
        if(cell==nil)
        {
            cell = [SectionOneTableViewCell alloc];
            cell.sectionOneFrame = [tableView rectForRowAtIndexPath:indexPath];
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneCellID"];
            //通过tag获得按钮并且添加点击事件
            for (int i = 1; i<9; i++) {
                UIButton *btn = (UIButton *)[cell viewWithTag:i];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            }

        }
        return cell;
    }
    else
    {
        SectionTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCellID"];
        if(!cell)
        {
            cell = [[SectionTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"twoCellID"];
            
        }
        [cell configIndexListData:self.indexDataArray[indexPath.row]];
        return cell;
    }
}
#pragma mark -load data
-(void)loadData
{
    NSString *str =@"https://app.baichengyiliao.com/main.php/doctor/cms/article/getArticleByCategoryAndTag/%5B%5D/3/50/1/0.json?num=3&time";
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    self.indexDataArray = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_tableView.mj_header endRefreshing];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = dic[@"data"];
        for (int i =0; i<array.count; i++) {
            IndexDataModel * dataModel =[[IndexDataModel alloc]init];
            [dataModel setValuesForKeysWithDictionary:array[i]];
            [self.indexDataArray addObject:dataModel];
        }
        //刷新列表
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    
}
#pragma mark - click button
-(void)clickButton:(UIButton *)button
{
    switch (button.tag) {
        case 1:
        {
            //问医生
            AskDoctorsViewController *askVC = [[AskDoctorsViewController alloc] init];
            askVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:askVC animated:YES];
        }
            NSLog(@"ask docter ");
            break;
        case 2:
            //预约就诊
        {
            AppointmentViewController *appointmentVC = [[AppointmentViewController alloc] init];
            appointmentVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:appointmentVC animated:YES];
        }
            NSLog(@"预约就诊");
            break;
        case 3:
            //智慧医疗
        {
            WisdomMedicalViewController *wisdomMedicalVC = [[WisdomMedicalViewController alloc] init];
            wisdomMedicalVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wisdomMedicalVC animated:YES];
        }
            break;
        case 4:
            //预约药品
        {
            TYH_WebViewController *drugsVC = [[TYH_WebViewController alloc] init];
            drugsVC.url = @"https://oneitfarm.com/utemplate/main.php?action=tpl_view.html&appkey=l03or2hyxqvayplikfmnc69edmcsgbix&channel=0&id=3634&pub=1&token=KzYDA0dWGXO8q4M7.tq8rZ2hjsvCBx5ca.371884d79bd4249af583ba2757d601c0";
            drugsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:drugsVC animated:YES];
            
        }
            break;
        case 5:
            //养生堂
        {
            [self.tabBarController setSelectedIndex:2];
        }
            break;
        case 6:
            //报告咨询
        {
            ReportViewController *reportVC = [[ReportViewController alloc] init];
            reportVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:reportVC animated:YES];
        }
            break;
        case 7:
            //健康自测
        {
            HealthTestViewController *healthTestVC = [[HealthTestViewController alloc] init];
            healthTestVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:healthTestVC animated:YES];
        }
            break;
        case 8:
            //金币商城
        {
            TYH_WebViewController *creditShopVC = [[TYH_WebViewController alloc] init];
            creditShopVC.url = @"https://oneitfarm.com/utemplate/main.php?action=tpl_view.html&appkey=l03or2hyxqvayplikfmnc69edmcsgbix&channel=0&id=3069&pub=1&token=KzYDA0dWGXO8q4M7.tq8rZ2hjsvCBx5ca.371884d79bd4249af583ba2757d601c0";
            creditShopVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:creditShopVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - lazyload

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             [self loadData];
        }];
        [_tableView.mj_header beginRefreshing];
        _tableView.delegate =self;
        _tableView.dataSource= self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSMutableArray *)indexDataArray
{
    if (_indexDataArray==nil)
    {
    
        _indexDataArray = [[NSMutableArray alloc]init];
    }
    return _indexDataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
