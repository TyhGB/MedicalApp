//
//  UserDataBase.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface UserDataBase : NSObject
+(instancetype)sharedUserDataBase;
//注册增加用户
-(void)addUser:(UserModel *)user;
//根据手机号码查询用户是否存在
-(BOOL)searchUser:(NSInteger) phone;
//如果存在匹配密码判断是否登陆成功
-(BOOL)matchPWD:(NSString *)pwd;
//重置密码
-(void)resetPWD:(NSString *)pwd Phone:(NSInteger)phone;
//根据手机号获得用户信息，返回值为NSMutableDictonnary
-(NSMutableDictionary *)getUserInfo:(NSInteger ) phone;
//重置昵称
-(void)resetName:(NSString *)name Phone:(NSInteger)phone;
//存入头像图片
-(void)setHeadPicture:(UIImage *)image Phone:(NSInteger)phone;
//获取头像图片
-(UIImage *)getHeadPicture:(NSInteger )phone;

@end
