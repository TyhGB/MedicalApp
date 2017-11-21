//
//  FphoneNumberTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "FphoneNumberTableViewCell.h"
#import <SVProgressHUD.h>

@interface FphoneNumberTableViewCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextField *textField;

@end
@implementation FphoneNumberTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置控件位置
        self.label.frame = CGRectMake(0, 0, 80, 50);
        self.textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-80, 50);
        self.textField.placeholder = @"请输入手机号码";
        self.label.text = @"手机号";
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
        //如果超过11位跳出提示
        if (textField.text.length+string.length>11) {
            [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
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
        //呼出键盘为纯数字
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        //为了父视图获得该控件设定tag
        _textField.tag=100;
        //编辑是右侧出现一键清空
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
    }
    return _textField;
}

@end
