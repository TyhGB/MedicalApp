//
//  HeadTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "HeadTableViewCell.h"

@interface HeadTableViewCell ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *headView;
@end
@implementation HeadTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.headView];
    }
    return self;
}

-(void)configHeadView:(UIImage *)image
{
    self.headView.image = image;
}

-(UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 100)];
        _label.text = @"头像";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
-(UIImageView *)headView
{
    if (_headView==nil) {
        _headView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 10, 80, 80)];
        _headView.layer.cornerRadius = 40;
        _headView.layer.masksToBounds = YES;
        _headView.layer.borderWidth = 1;
    }
    return _headView;
}

@end
