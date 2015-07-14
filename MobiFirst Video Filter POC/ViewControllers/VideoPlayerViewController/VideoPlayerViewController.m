//
//  VideoPlayerViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 14/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = TEXT_NAVIGATION_BAR_TITLE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSURL*  url = [NSURL URLWithString:_videoPlayBackRequestString];
    NSURLRequest*   request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
