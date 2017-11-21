//
//  ClinicViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ClinicViewController.h"
#import "TopViewTableViewCell.h"
#import "ClinicTableViewCell.h"
#import "AFNetworking.h"
#import "IndexDataModel.h"
#import "ClinicTaps.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "IndexDataModel.h"
#import "TYH_WebViewController.h"

@interface ClinicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,strong) NSMutableArray *newestDataArrray;
@property(nonatomic,assign) NSInteger currentTag;//选项卡标志
@property (nonatomic,strong) NSMutableArray *btnTitleArray;  //选项卡按钮数组
@property(nonatomic,strong) UIView *downView;//选项卡下划线
@property(nonatomic,assign) CGFloat btnWidth;//选项卡宽度
@property (nonatomic,strong) NSString *datalistStirng;//点击按钮加载的网址

@end

@implementation ClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    设置菊花
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    //设置遮罩
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [self.view addSubview:self.tableView];
    NSLog(@"viewdidload");

}

#pragma mark - tableView delegate and datasouce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {

        return 1;
    }
    else
    {
        return self.newestDataArrray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }
    else
    {
        return 100;
    }
}
//中间选项卡的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 42;
    }
    else
    {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //顶部轮播
    if (indexPath.section==0) {
        TopViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTopSection"];
        if (cell==nil) {
            cell = [TopViewTableViewCell alloc];
            cell.cellFrame = [tableView rectForRowAtIndexPath:indexPath];
            cell.clinicViewController = self;
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTopSection"];
        }
        return cell;
    }
    //底部数据
    else
    {
        ClinicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[ClinicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell configClinicListData:self.newestDataArrray[indexPath.row]];
        return cell;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        ClinicTaps *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"taps"];
        if (view==nil) {
            view = [[ClinicTaps alloc]initWithReuseIdentifier:@"taps"];
//            view = [[ClinicTabs alloc]initWithFrame:[tableView rectForHeaderInSection:section]];
            for (int i=0; i<view.btnTitleArray.count; i++)
            {
                [view.btnTitleArray[i] addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
                self.btnTitleArray = view.btnTitleArray;
                self.btnWidth = view.btnWidth;
                self.downView = view.downView;
                self.currentTag = view.currentTag;
            }
            
        }
        return view;
    }
    else
    {
        return nil;
    }
}
//选项卡点击事件
-(void)changeBtn:(UIButton *)btn
{
    if ((btn.tag-1)!=self.currentTag) {
        [self.btnTitleArray[self.currentTag] setSelected:NO];
        [self.btnTitleArray[btn.tag-1] setSelected:YES];
        [UIView animateWithDuration:0.3 animations:^{
            [self.downView setFrame:CGRectMake((btn.tag-1)*self.btnWidth,40, self.btnWidth, 2)];
        }];
        self.currentTag = btn.tag-1;
        switch (self.currentTag) {
            case 0:
                self.datalistStirng = @"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/37.json?article_num=20&category_id=37&page=1&showedtime&substrcount=50";
                break;
            case 1:
                self.datalistStirng = @"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/37.json?article_num=20&category_id=37&page=1&showedtime&substrcount=50";
                break;
            case 2:
                self.datalistStirng = @"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/23.json?article_num=20&category_id=23&page=1&showedtime&substrcount=50";
                break;
            case 3:
                self.datalistStirng = @"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/22.json?article_num=20&category_id=22&page=1&showedtime&substrcount=50";
                break;
            case 4:
                self.datalistStirng = @"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/9.json?article_num=20&category_id=9&page=1&showedtime&substrcount=50";
                break;
            default:
                break;
        }
        self.newestDataArrray = nil;
        [SVProgressHUD showWithStatus:@"正在获取数据"];
        //重置上啦刷新状态
        [self.tableView.mj_footer resetNoMoreData];
        [self loadData:self.datalistStirng];
    }
}
//点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYH_WebViewController *listInfo = [[TYH_WebViewController alloc] init];
    IndexDataModel * dataModel = self.newestDataArrray[indexPath.row];
    NSString *url = @"https://oneitfarm.com/cms/";
    url = [url stringByAppendingString:dataModel.link];
    listInfo.url = url;
    listInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listInfo animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - load data
-(void)loadData:(NSString *)str
{
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [_tableView.mj_header endRefreshing];
        //移除历史数据
        [self.newestDataArrray removeAllObjects];
        //json解析数据
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = dic[@"data"];
        for (int i =0; i<array.count; i++) {
            IndexDataModel *model = [[IndexDataModel alloc]init];
            [model setValuesForKeysWithDictionary:array[i]];
            [self.newestDataArrray addObject:model];
        }
        //数据刷新
        dispatch_async(dispatch_get_main_queue(), ^{
               [self.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy load
-(UITableView *)tableView
{
    if(_tableView==nil)
    {
        _tableView =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        [SVProgressHUD showWithStatus:@"正在获取数据"];
        [self loadData:@"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/37.json?article_num=20&category_id=37&page=1&showedtime&substrcount=50"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.btnTitleArray[self.currentTag] setSelected:NO];
            self.currentTag = 0;
            [self.btnTitleArray[self.currentTag] setSelected:YES];
            [SVProgressHUD showWithStatus:@"正在获取数据"];
            [self loadData:@"https://app.baichengyiliao.com/main.php/doctor/cms/article/category/37.json?article_num=20&category_id=37&page=1&showedtime&substrcount=50"];
            [UIView animateWithDuration:0.3 animations:^{
                [self.downView setFrame:CGRectMake(0,40, self.btnWidth, 2)];
            }];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }];
        _tableView.delegate=self;
        _tableView.dataSource = self;
//        [_tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}
-(NSMutableArray *)newestDataArrray
{
    if (_newestDataArrray==nil) {
        _newestDataArrray = [[NSMutableArray alloc]init];
    }
    return _newestDataArrray;
}
-(NSMutableArray *)btnTitleArray
{
    if(_btnTitleArray==nil)
    {
        _btnTitleArray = [[NSMutableArray alloc]init];
    }
    return _btnTitleArray;
}
-(UIView *)downView
{
    if (_downView==nil) {
        _downView = [[UIView alloc]init];
    }
    return _downView;
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
