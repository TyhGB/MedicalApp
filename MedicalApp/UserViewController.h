//
//  UserViewController.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserViewControllerDelegate <NSObject>

-(void)changeName:(NSString *) name;

//更新上一级头像
-(void)updateHead:(UIImage *)image;

@end

@interface UserViewController : UIViewController

@property (nonatomic,strong)id <UserViewControllerDelegate> delegate;

@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) UIImage *image;
@end
