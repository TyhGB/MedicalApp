//
//  TYH_WebViewController.m
//  test
//
//  Created by TyhOS on 2017/11/19.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "TYH_WebViewController.h"
#import "WebProgressLayer.h"

@interface TYH_WebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) WebProgressLayer *layer;
//@property (nonatomic) int start;
//@property (nonatomic) int finished;
@end
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation TYH_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
    [self.webview loadRequest:request];
    [self.view addSubview:self.webview];

    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
        self.layer = [[WebProgressLayer alloc] init];
        _layer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 2);
        [self.view.layer addSublayer:_layer];
        [self.layer startLoad];
//        self.start++;
//        NSLog(@"start:%d",self.start);
  
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.layer finishLoad];
//    self.finished++;
////    NSLog(@"finished:%d",self.finished);
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.layer finishLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
