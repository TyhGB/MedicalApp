//
//  AskDoctorsViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "AskDoctorsViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJRefresh.h>

@interface AskDoctorsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *selectView;
@property(nonatomic,strong)NSArray *doctorsArray;
@end

@implementation AskDoctorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图文咨询";
    [self.view addSubview:self.tableView];
    [self loadData];
    self.tableView.tableHeaderView = self.selectView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.doctorsArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(void)loadData
{
    [SVProgressHUD showWithStatus: @"正在加载"];
    NSString *urlString = @"https://app.baichengyiliao.com/main.php/patient/service/doctorList.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        self.doctorsArray = [dic valueForKey:@"doctors"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get doctorsList failed");
    }];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
    }
    return _tableView;
}
-(NSArray *)doctorsArray
{
    if (!_doctorsArray) {
        _doctorsArray = [[NSArray alloc] init];
    }
    return _doctorsArray;
}
-(UIView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:_selectView.frame];
        label.text = @"    请选择医生";
        label.textColor = [UIColor orangeColor];
        [_selectView addSubview:label];
    }
    return _selectView;
}

@end
