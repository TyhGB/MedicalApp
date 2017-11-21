//
//  ClinicTaps.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/15.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicTaps : UITableViewHeaderFooterView
@property(nonatomic,strong) NSMutableArray *btnTitleArray;//选项卡按钮数组
@property(nonatomic,assign) CGFloat btnWidth;//选项卡宽度
@property(nonatomic,strong) UIView *downView;//选项卡下划线

@property(nonatomic,assign) NSInteger currentTag;//选项卡标志
@end
