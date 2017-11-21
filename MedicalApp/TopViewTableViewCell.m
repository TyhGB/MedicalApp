//
//  TopViewTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/15.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "TopViewTableViewCell.h"
#import "SDCycleScrollView.h"
#import "TYH_WebViewController.h"

@interface TopViewTableViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * imageUrlArray;
@property (nonatomic,strong) NSMutableArray * imageInfoUrlArray;

@end
@implementation TopViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _cellFrame.origin = CGPointZero;
        self.frame = _cellFrame;
        NSString *str1 = @"https://img2.ciurl.cn/flashsale/upload/xinfotek_upload/2017/02/21/1487668346389556.jpg_a_750x400";
        NSURL *url1 = [NSURL URLWithString:str1];
        NSString *str2 = @"https://img2.ciurl.cn/flashsale/upload/xinfotek_upload/2017/02/21/1487669417635688.jpg_a_750x400";
        NSURL *url2 = [NSURL URLWithString:str2];
        NSString *str3 = @"https://img2.ciurl.cn/flashsale/upload/xinfotek_upload/2017/02/21/1487668264435772.jpg_a_750x400";
        NSURL *url3 = [NSURL URLWithString:str3];
        self.imageUrlArray = [NSMutableArray arrayWithCapacity:3];
        [self.imageUrlArray addObject:url1];
        [self.imageUrlArray addObject:url2];
        [self.imageUrlArray addObject:url3];
        SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame imageURLStringsGroup:self.imageUrlArray];
        cycleScrollView.delegate =self;
        NSArray *titles = @[@"单人洁牙套餐",@"单人美国beyong冷光美白+洗牙套餐",@"儿童窝沟封闭套餐"];
        cycleScrollView.titlesGroup =titles;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        [self.contentView addSubview:cycleScrollView];
    }
    return self;
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    TYH_WebViewController *infoVC = [[TYH_WebViewController alloc] init];
    infoVC.url =self.imageInfoUrlArray[index];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.clinicViewController.navigationController pushViewController:infoVC animated:YES];
}

-(NSMutableArray *)imageInfoUrlArray
{
    NSArray *array = [NSArray arrayWithObjects:@"https://oneitfarm.com/cms/main.php?action=f_article.html&channel=3&user_id=&appkey=1lnyw4pvihlddowusxk8vpeyn5gfhfij&id=183",@"https://oneitfarm.com/cms/main.php?action=f_article.html&channel=3&user_id=&appkey=1lnyw4pvihlddowusxk8vpeyn5gfhfij&id=184",@"https://oneitfarm.com/cms/main.php?action=f_article.html&channel=3&user_id=&appkey=1lnyw4pvihlddowusxk8vpeyn5gfhfij&id=182", nil];
    _imageInfoUrlArray = [[NSMutableArray alloc]initWithArray:array];;
    return _imageInfoUrlArray;
}
@end
