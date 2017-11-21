//
//  ClinicTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/11.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ClinicTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ClinicTableViewCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *sourceLabel;

@end
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ClinicTableViewCell

-(void)setupFrame
{
    self.titleLabel.frame = CGRectMake(10, 10, WIDTH-30-80, 50);
    self.contentLabel.frame = CGRectMake(10, 60, WIDTH-30-80, 15);
    self.timeLabel.frame = CGRectMake(10, 75, WIDTH-30-80, 15);
    self.imgView.frame = CGRectMake(WIDTH-90, 10, 80, 80);
    self.sourceLabel.frame = CGRectMake(0, 0, 100, 15);
//    _titleLabel.layer.borderWidth = 1;
//    _contentLabel.layer.borderWidth = 1;
//    _timeLabel.layer.borderWidth = 1;
//    _imgView.layer.borderWidth=1;
//    _sourceLabel.layer.borderWidth = 1;
}

-(void)setupViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.imgView];
    [self.timeLabel addSubview:self.sourceLabel];
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

-(void)setSoucreLabelHidden:(BOOL)yesOrNo
{
    if (yesOrNo==YES) {
        self.sourceLabel.hidden=YES;
    }
    else
    {
        self.sourceLabel.hidden=NO;
    }
}

#pragma mark - setup data
//设置数据
-(void)configClinicListData:(IndexDataModel *)indexListData
{
    self.titleLabel.text = indexListData.title;
    self.contentLabel.text = indexListData.content;
    //拆分时间
    self.timeLabel.text = [indexListData.created substringToIndex:10];
    //拼接图片地址
    NSString *urlString = [[NSString alloc]initWithFormat:@"%@%@",@"https:",indexListData.img];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
//    self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    //来源
    self.sourceLabel.text = indexListData.categoryname;
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
        [_imgView sizeToFit];
    }
    return _imgView;
}
-(UILabel *)sourceLabel
{
    if (_sourceLabel==nil) {
        _sourceLabel = [UILabel new];
        _sourceLabel.textColor = [UIColor grayColor];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _sourceLabel;
}
@end
