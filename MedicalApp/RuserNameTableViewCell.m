//
//  RuserNameTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "RuserNameTableViewCell.h"
#import <SVProgressHUD.h>

@interface RuserNameTableViewCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextField *textField;

@end
@implementation RuserNameTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置控件位置
        self.label.frame = CGRectMake(0, 0, 80, 50);
        self.textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-80, 50);
        self.textField.placeholder = @"16位字母数字或8位汉字以内";
        self.label.text = @"用户名";
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.textField];
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
#pragma mark - textFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string>0) {
        //如果超过16位跳出提示
        if (textField.text.length+string.length>16) {
            [SVProgressHUD showErrorWithStatus:@"用户名过长"];
            //一秒延迟收回
            [SVProgressHUD dismissWithDelay:1.0];
            //键盘收回
            [self.textField resignFirstResponder];
            return NO;
        }
    }
    return YES;
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
-(UITextField *)textField
{
    if (_textField==nil) {
        _textField = [[UITextField alloc]init];
        //为了父视图获得该控件设定tag
        _textField.tag=101;
        //编辑是右侧出现一键清空
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
    }
    return _textField;
}

@end
