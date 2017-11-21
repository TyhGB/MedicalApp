//
//  AppointmentViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "AppointmentViewController.h"
#import <SVProgressHUD.h>
#import "AFNetworking.h"

@interface AppointmentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) UITableView *tableview;
@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.segment;
    UIBarButtonItem *appointHistory = [[UIBarButtonItem alloc] initWithTitle:@"预约记录" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = appointHistory;
    [self.view addSubview:self.tableview];
}
-(void)selectSegment
{
    if (self.segment.selectedSegmentIndex == 0) {
        self.tableview.hidden = NO;
    }else{
        self.tableview.hidden = YES;
    }
}

#pragma mark - Tableview DataSource andd Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = @"医生团队";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

#pragma mark - lazy load
-(UISegmentedControl *)segment
{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"科室",@"服务"]];
        _segment.selectedSegmentIndex = 0;
        CGRect rect;
        rect.origin.x = self.view.frame.size.width/3;
        rect.origin.y = 0;
        rect.size.width = self.view.frame.size.width/3;
        rect.size.height = 32;
        _segment.frame = rect;
        [_segment addTarget:self action:@selector(selectSegment) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    
    }
    return _tableview;
}
@end
