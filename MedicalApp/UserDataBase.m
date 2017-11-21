//
//  UserDataBase.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "UserDataBase.h"
#import <FMDB.h>

static UserDataBase *_DBCtl = nil;

@interface UserDataBase ()
{
    FMDatabase *_userDB;
}
@end
@implementation UserDataBase
+(instancetype)sharedUserDataBase
{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[UserDataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
}
-(void)initDataBase
{
    //获得documents路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //文件路径第一次会创建
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"userDB.sqlite"];
    // 实例化FMDataBase对象
    _userDB = [FMDatabase databaseWithPath:filePath];
    //打开数据库
    [_userDB open];
    //写好sql语句create table user (id integer primary key)
    NSString *userSql =@"CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,userPhone VARCHAR(255) UNIQUE,userName VARCHAR(255),userPWD VARCHAR(255))";
    //执行语句
    [_userDB executeUpdate:userSql];
    //关闭数据库
    [_userDB close];
    
}
-(void)addUser:(UserModel *)user
{
    [_userDB open];
    [_userDB executeUpdate:@"INSERT INTO user(userPhone,userName,userPWD)VALUES(?,?,?)",@(user.phone),user.name,user.pwd];//数字要加上@()否则崩溃，原因 需要封装城NSNumber格式
    [_userDB close];
}
-(BOOL)searchUser:(NSInteger)phone
{
    [_userDB open];
    FMResultSet *result = [_userDB executeQuery:@"SELECT userPhone FROM user WHERE userPhone==?",@(phone)];
    if ([result next]) {
        [_userDB close];
        return YES;
    }
    else
    {
        [_userDB close];
        return NO;
    }
    
}
-(BOOL)matchPWD:(NSString *)pwd
{
    [_userDB open];
    FMResultSet *result = [_userDB executeQuery:@"SELECT * FROM user WHERE userPWD=?",pwd];
    if ([result next]) {
        [_userDB close];
        return YES;
    }
    else
    {
        [_userDB close];
        return NO;
    }
}
-(void)resetPWD:(NSString *)pwd Phone:(NSInteger)phone
{
    [_userDB open];
    [_userDB executeUpdate:@"UPDATE user SET userPWD = ? WHERE userPhone==?",pwd,@(phone)];
    [_userDB close];
}
-(NSMutableDictionary *)getUserInfo:(NSInteger)phone
{
    [_userDB open];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    //查找到phone的用户信息
    FMResultSet * result = [_userDB executeQuery:@"SELECT * FROM user WHERE userPhone=?",@(phone)];
    if ([result next]) {
        [dic setObject:[result stringForColumn:@"userPhone"] forKey:@"phone"];
        [dic setObject:[result stringForColumn:@"userName"] forKey:@"name"];
        [dic setObject:[result stringForColumn:@"userPWD"] forKey:@"PWD"];
        //新用户 没有选择头像 所以需要判断 不为空才设置
        if ([result dataForColumn:@"userPicture"]) {
            [dic setObject:[result dataForColumn:@"userPicture"] forKey:@"picture"];
        }
        NSLog(@"getUserDic:%@",dic);
    }
//    dic = [result columnNameToIndexMap];
//    NSLog(@"getUserDic:%@",dic);
    [_userDB close];
    return dic;
}
-(void)resetName:(NSString *)name Phone:(NSInteger)phone
{
    [_userDB open];
    [_userDB executeUpdate:@"UPDATE user SET userName=? WHERE userPhone=?",name,@(phone)];
    FMResultSet *result = [_userDB executeQuery:@"SELECT * FROM user"];
    if ([result next]) {
        NSString *name = [result stringForColumn:@"userName"];
        NSString *phone = [result stringForColumn:@"userPhone"];
        NSString *pwd = [result stringForColumn:@"userPWD"];
        NSLog(@"name:%@,phone:%@,pwd:%@",name,phone,pwd);
    }
    [_userDB close];
}
-(void)setHeadPicture:(UIImage *)image Phone:(NSInteger)phone
{
    [_userDB open];
    //判断是否存在列userPicture 否则添加列
    if (![_userDB columnExists:@"userPicture" inTableWithName:@"user"]) {
        //sql语句 创建头像图片列 数据类型为blob
        NSString *alterStr = @"ALTER TABLE user ADD userPicture BLOB";
        BOOL worked = [_userDB executeUpdate:alterStr];
        if (worked) {
            NSLog(@"插入成功");
        }
        else
        {
            NSLog(@"插入失败");
        }
    }
    else
    {
        //存在userPicture列所以将图片转换为数据格式存入数据库
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        BOOL worked = [_userDB executeUpdate:@"UPDATE user SET userPicture=? WHERE userPhone=?",imageData,@(phone)];
        if (worked) {
            NSLog(@"头像存储成功");
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//            //查找到phone的用户信息
//            FMResultSet * result = [_userDB executeQuery:@"SELECT * FROM user WHERE userPhone=?",@(phone)];
//            if ([result next]) {
//                [dic setObject:[result stringForColumn:@"userPhone"] forKey:@"phone"];
//                [dic setObject:[result stringForColumn:@"userName"] forKey:@"name"];
//                [dic setObject:[result stringForColumn:@"userPWD"] forKey:@"PWD"];
//                [dic setObject:[result dataForColumn:@"userPicture"] forKey:@"picture"];
//                NSLog(@"after set headview:%@",dic);
//            }
//            dic = [result columnNameToIndexMap];
//            NSLog(@"after set head picture:%@",dic);
        }
        else
        {
            NSLog(@"头像存储失败");
        }
    }
    [_userDB close];
}
-(UIImage *)getHeadPicture:(NSInteger)phone
{
    UIImage *image = [[UIImage alloc]init];
    [_userDB open];
    FMResultSet * result = [_userDB executeQuery:@"SELECT * FROM user WHERE userPhone=?",@(phone)];
    if ([result next]) {
        NSData *imageData = [result dataForColumn:@"userPicture"];
//        NSLog(@"imagedata:%@",imageData);
        image = [UIImage imageWithData:imageData];
    }
    [_userDB close];
    return  image;
}
@end
