//
//  SectionZeroTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/7.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SectionZeroTableViewCell.h"
#import "SDCycleScrollView.h"
#import "TYH_WebViewController.h"

@interface SectionZeroTableViewCell ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * imageUrlArray;
@property (nonatomic,strong) NSMutableArray * imageInfoUrlArray;
@end


@implementation SectionZeroTableViewCell 

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellFrame.origin = CGPointZero;
        self.frame = _cellFrame;
        //图片的网址
        NSURL *url1 = [NSURL URLWithString:@"https://img2.ciurl.cn/flashsale/upload/xinfotek_upload/2017/02/21/1487669670669627.jpg_a_750x400"];
        NSURL *url2 = [NSURL URLWithString:@"https://img2.ciurl.cn/flashsale/upload/xinfotek_upload/2017/02/21/1487669561752898.jpg_a_750x400"];
        self.imageUrlArray = [NSMutableArray arrayWithCapacity:2];
        [self.imageUrlArray addObject:url1];
        [self.imageUrlArray addObject:url2];
//        NSArray *urlArray = [NSArray arrayWithObjects:url1,url2, nil];
        //SDCycleScrollView 一个无限轮播的第三方库的调用
        SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame imageURLStringsGroup:self.imageUrlArray];
        //自动轮播时间
        cycleScrollView.autoScrollTimeInterval = 3.0;
        cycleScrollView.delegate =self;
        [self.contentView addSubview:cycleScrollView];
    }
    return self;
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    TYH_WebViewController *infoVC = [[TYH_WebViewController alloc] init];
    infoVC.url = self.imageInfoUrlArray[index];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.indexViewController.navigationController pushViewController:infoVC animated:YES];
}
-(NSMutableArray *)imageInfoUrlArray
{
    NSArray *array = [NSArray arrayWithObjects:@"https://oneitfarm.com/cms/main.php?action=f_article.html&channel=3&user_id=&appkey=1lnyw4pvihlddowusxk8vpeyn5gfhfij&id=183",@"https://oneitfarm.com/cms/main.php?action=f_article.html&channel=3&user_id=&appkey=1lnyw4pvihlddowusxk8vpeyn5gfhfij&id=182", nil];
    _imageInfoUrlArray = [[NSMutableArray alloc]initWithArray:array];;
    return _imageInfoUrlArray;
}
@end
