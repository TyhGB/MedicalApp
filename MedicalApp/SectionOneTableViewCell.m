//
//  SectionOneTableViewCell.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SectionOneTableViewCell.h"
#import "ButtonCustom.h"

@interface SectionOneTableViewCell()
@property(nonatomic,strong) NSArray *array;
@end


@implementation SectionOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i=1; i<9; i++) {
            ButtonCustom * button = [ButtonCustom buttonWithType:UIButtonTypeCustom];
            button.frame =  CGRectMake((i-1)%4*(_sectionOneFrame.size.width/4), (i/5)*80, _sectionOneFrame.size.width/4, _sectionOneFrame.size.height/2);
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            //设置按钮正常和选中为同一张图片（取消按住按钮置灰效果）
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateHighlighted];
            [button setTitle:self.array[i-1] forState:UIControlStateNormal];
            //设置标题颜色：黑色
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //设置文字居中、字体
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            //添加点击事件
            button.tag = i;
//            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            
        }
        
    }

    
    return self;
}


-(NSArray *)array
{
    //八个button的标题
    _array = @[@"问医生",@"预约就诊",@"智慧医疗",@"预约药品",@"养生堂",@"报告咨询",@"健康自测",@"金币商城"];
    return _array;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
