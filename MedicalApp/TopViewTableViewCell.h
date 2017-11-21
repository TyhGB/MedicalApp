//
//  TopViewTableViewCell.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/15.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinicViewController.h"

@interface TopViewTableViewCell : UITableViewCell

@property (nonatomic) CGRect cellFrame;
@property (nonatomic,strong) ClinicViewController *clinicViewController;
@end
