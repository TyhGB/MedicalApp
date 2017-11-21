//
//  OrganizationTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "OrganizationTableViewCell.h"
@interface OrganizationTableViewCell ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *organizationBtn;

@end
@implementation OrganizationTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label.frame = CGRectMake(0, 0, 80, 50);
        self.label.text = @"机构";
        [self.contentView addSubview:self.label];
        self.organizationBtn.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-80, 50);
        [self.organizationBtn setTitle:@"孕期提醒"  forState:UIControlStateNormal];
        [self.contentView addSubview:self.organizationBtn];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}
//为空表示取消点击选中效果和setHighLighted一起使用
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}
#pragma mark - lazy load
-(UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
-(UIButton *)organizationBtn
{
    if (_organizationBtn==nil) {
        _organizationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_organizationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //居左
        _organizationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _organizationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _organizationBtn;
}

@end
