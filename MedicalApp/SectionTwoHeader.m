//
//  SectionTwoHeader.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/16.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SectionTwoHeader.h"
#import "ClinicViewController.h"

@interface SectionTwoHeader ()

@property (nonatomic,strong) UILabel *label;


@end
@implementation SectionTwoHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.moreBtn];
    return self;
}
-(UILabel *)label
{
    if (_label==nil) {
        _label  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-100, 50)];
        _label.text = @"推荐";
        _label.backgroundColor = [UIColor whiteColor];
    }
    return _label;
}
-(UIButton *)moreBtn
{
    if (_moreBtn==nil) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-90, 5, 80, 40);
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"moreBtn"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

@end
