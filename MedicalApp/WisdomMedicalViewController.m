//
//  WisdomMedicalViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "WisdomMedicalViewController.h"

@interface WisdomMedicalViewController ()
@property (nonatomic,strong) UITextView *textView;
@end

@implementation WisdomMedicalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的设备";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.view addSubview:self.textView];
}
-(UITextView *)textView
{
    if (!_textView) {
        CGRect rect;
        rect.origin = CGPointZero;
        rect.size = CGSizeMake(200, 200);
        _textView = [[UITextView alloc] initWithFrame:rect];
        _textView.center = self.view.center;
        _textView.text = @"目前尚未使用任何设备\n请点击屏幕右上角添加设备";
        _textView.textColor = [UIColor blackColor];
        _textView.selectable = NO;
        _textView.scrollEnabled = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
    }
    return _textView;
}
@end
