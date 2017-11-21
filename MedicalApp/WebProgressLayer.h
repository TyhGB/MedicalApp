//
//  WebProgressLayer.h
//  test
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WebProgressLayer : CAShapeLayer

+(instancetype)layerWithFrame:(CGRect)frame;

-(void)startLoad;
-(void)finishLoad;

@end
