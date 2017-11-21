//
//  SectionZeroTableViewCell.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/7.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"

@interface SectionZeroTableViewCell : UITableViewCell

@property (nonatomic) CGRect cellFrame;
@property (nonatomic,strong) IndexViewController *indexViewController;
@end
