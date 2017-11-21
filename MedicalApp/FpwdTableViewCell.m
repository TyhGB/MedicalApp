//
//  FpwdTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "FpwdTableViewCell.h"
#import <SVProgressHUD.h>

@interface FpwdTableViewCell()<UITextFieldDelegate>



@property (nonatomic,strong) UIButton *pwdBtn;

@end
@implementation FpwdTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置控件位置
        self.label.frame = CGRectMake(0, 0, 80, 50);
        self.textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-80, 50);
        self.textField.placeholder = @"6-20位字母或数字";
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

#pragma mark -delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length+string.length>20) {
        //密码不能超过20位
        [SVProgressHUD showErrorWithStatus:@"密码不能超过20位"];
        [SVProgressHUD dismissWithDelay:1.0];
        //收回键盘
        [self.textField resignFirstResponder];
        return NO;
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
-(UIButton *)pwdBtn
{
    if (_pwdBtn==nil) {
        _pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pwdBtn.frame = CGRectMake(0, 0, 50, 50);
        [_pwdBtn setBackgroundImage:[UIImage imageNamed:@"pwdClose"]  forState:UIControlStateNormal];
        [_pwdBtn setBackgroundImage:[UIImage imageNamed:@"pwdOpen"] forState:UIControlStateSelected];
        [_pwdBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdBtn;
}
-(UITextField *)textField
{
    if (_textField==nil) {
        _textField = [[UITextField alloc]init];
        //        _textField.tag =101;tag在forgetviewcontroller中设置，因为两个cell用的文件一样，需要在外面设置tag区别，和设置label的标题道理相同
        //编辑是右侧出现一键清空
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //设置为密码输入模式
        [_textField setSecureTextEntry:YES];
        _textField.delegate = self;
        _textField.rightView = self.pwdBtn;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}
//切换密码显示模式
-(void)click
{
    self.pwdBtn.selected = !self.pwdBtn.selected;
    if (self.pwdBtn.selected == YES) {
        //显示模式
        self.textField.secureTextEntry = NO;
    }
    else
    {
        //隐藏模式
        self.textField.secureTextEntry = YES;
    }
}

@end
