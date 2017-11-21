//
//  UserModel.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/27.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,assign) NSInteger phone;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *pwd;
@end
