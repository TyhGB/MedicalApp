//
//  ClinicTaps.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/15.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ClinicTaps.h"

@implementation ClinicTaps

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * titleArray = @[@"最新",@"养生堂",@"特色服务",@"活动",@"医学通识"];
        NSInteger number = titleArray.count;
        self.btnWidth = ([UIScreen mainScreen].bounds.size.width)/number;
        for(int i=0;i<titleArray.count;i++)
        {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*self.btnWidth,0,self.btnWidth,40);
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.tag = i+1;
            if (i==0)
            {
                self.downView.frame = CGRectMake(i*self.btnWidth, 40, self.btnWidth, 2);
                [self addSubview:self.downView];
                btn.selected = YES;
            }
            [self addSubview:btn];
            [self.btnTitleArray addObject:btn];
        }
    }
    return self;
}
-(NSMutableArray *)btnTitleArray
{
    if (_btnTitleArray==nil) {
        _btnTitleArray = [[NSMutableArray alloc]init];
    }
    return _btnTitleArray;
}
-(UIView *)downView
{
    if (_downView==nil) {
        _downView = [[UIView alloc]init];
        _downView.backgroundColor = [UIColor purpleColor];
    }
    return _downView;
}
@end
