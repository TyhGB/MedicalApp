//
//  UserPhoneTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "UserPhoneTableViewCell.h"

@interface UserPhoneTableViewCell ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label2;

@end
@implementation UserPhoneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.label2];
    }
    return self;
}
-(void)configPhone:(NSString *)phone
{
    self.label2.text = phone;
}

-(UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        _label.text = @"手机号";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
-(UILabel *)label2
{
    if (_label2==nil) {
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-150, 0, 150, 50)];
        _label2.textAlignment = NSTextAlignmentCenter;
    }
    return _label2;
}
@end
