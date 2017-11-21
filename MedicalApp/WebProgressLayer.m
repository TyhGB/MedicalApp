//
//  WebProgressLayer.m
//  test
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "WebProgressLayer.h"
#import <UIKit/UIKit.h>
@implementation WebProgressLayer
{
    CAShapeLayer *_layer;
    NSTimer *_timer;
}

+(instancetype)layerWithFrame:(CGRect)frame
{
    WebProgressLayer *layer = [[WebProgressLayer alloc] init];
    layer.frame = frame;
    return layer;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
-(void)initialize
{
    self.lineWidth = 2;
    self.strokeColor = [UIColor blueColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.strokeEnd += 0.01;
    }];
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)startLoad
{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.03]];
    if (self.strokeEnd>=0.8) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
-(void)finishLoad
{
    [_timer invalidate];
    _timer = nil;
    self.strokeEnd = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
        
    });
}
@end
