//
//  SetHeadViewController.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/31.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetHeadViewControllerDelegate <NSObject>
//更新上一级的头像
-(void)updateHead:(UIImage *)image;

@end

@interface SetHeadViewController : UIViewController
@property (nonatomic,strong) id <SetHeadViewControllerDelegate> delegate;
@property (nonatomic,assign)NSInteger phone;
@end
