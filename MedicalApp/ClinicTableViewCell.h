//
//  ClinicTableViewCell.h
//  MedicalApp
//
//  Created by TyhOS on 2017/10/11.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexDataModel.h"

@interface ClinicTableViewCell : UITableViewCell
-(void)setSoucreLabelHidden:(BOOL)yesOrNo;
-(void)configClinicListData:(IndexDataModel *) indexListData; //设置底部列表数据
@end
