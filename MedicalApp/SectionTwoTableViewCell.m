//
//  SectionTwoTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SectionTwoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SectionTwoTableViewCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *imgView;

@end
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation SectionTwoTableViewCell

-(void)setupFrame
{
    self.titleLabel.frame = CGRectMake(10, 10, WIDTH-30-80, 50);
    self.contentLabel.frame = CGRectMake(10, 60, WIDTH-30-80, 15);
    self.timeLabel.frame = CGRectMake(10, 75, WIDTH-30-80, 15);
    self.imgView.frame = CGRectMake(WIDTH-90, 10, 80, 80);
//    _titleLabel.layer.borderWidth = 1;
//    _contentLabel.layer.borderWidth = 1;
//    _timeLabel.layer.borderWidth = 1;
//    _imgView.layer.borderWidth=1;
}

-(void)setupViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.imgView];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupFrame];
        [self setupViews];
    }
    return self;
}
#pragma mark - setter


#pragma mark - setup data
//设置数据
-(void)configIndexListData:(IndexDataModel *)indexListData
{
    self.titleLabel.text = indexListData.title;
    self.contentLabel.text = indexListData.content;
    //拆分时间
    self.timeLabel.text = [indexListData.created substringToIndex:10];
    //拼接图片地址
    NSString *urlString = [[NSString alloc]initWithFormat:@"%@%@",@"https:",indexListData.img];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
}
#pragma mark - lazy load

-(UILabel *)titleLabel
{
    if(_titleLabel==nil)
    {
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel
{
    if (_contentLabel==nil) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}
-(UILabel *)timeLabel
{
    if(_timeLabel==nil)
    {
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeLabel;
}
-(UIImageView *)imgView
{
    if(_imgView==nil)
    {
    _imgView = [UIImageView new];
    }
    return _imgView;
}

@end
