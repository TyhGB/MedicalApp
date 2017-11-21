//
//  RetNameViewController.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/30.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RetNameViewControllerDelegate <NSObject>

-(void)changeName:(NSString *)name;

@end

@interface RetNameViewController : UIViewController

@property (nonatomic,strong) id <RetNameViewControllerDelegate> delegate;

-(void)configTextFieldText:(NSString *)name;
@property (nonatomic,strong) NSString *phone;
@end
