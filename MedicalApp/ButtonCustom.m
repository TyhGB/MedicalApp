//
//  ButtonCustom.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/9.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ButtonCustom.h"

@implementation ButtonCustom
//重写title和image方法
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = CGRectGetWidth(contentRect)/4.0;
    //图片的Y+图片的高度
    CGFloat titleY = CGRectGetHeight(contentRect)/8.0+50;
    CGFloat titleW = 50;
    CGFloat titleH = 16;
    CGRect rect = CGRectMake(titleX, titleY, titleW, titleH);
    return rect;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = CGRectGetWidth(contentRect)/4.0;
    CGFloat imageY = CGRectGetHeight(contentRect)/8.0;
    CGFloat imageW = 50;
    CGFloat imageH = 50;
    CGRect rect = CGRectMake(imageX, imageY,imageW, imageH);
    
    return rect;
}
@end
