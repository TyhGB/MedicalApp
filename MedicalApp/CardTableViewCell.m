//
//  CardTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "CardTableViewCell.h"

@interface CardTableViewCell ()
@property (nonatomic,strong) UILabel *label;
@end
@implementation CardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        _label.text = @"我的名片";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
@end
