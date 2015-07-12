//
//  WelcomeScreenViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 10/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "DKCircleButton.h"
#import "VideoEditorScreenViewController.h"

@interface WelcomeScreenViewController ()

@end

@implementation WelcomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpIntitialView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

/*!
 * @discussion Setup the view initially. Adding sub views to view controller. Private Method.
 * @param void
 * @return void
 */
-(void)setUpIntitialView
{
    
    self.navigationItem.title = TEXT_NAVIGATION_BAR_TITLE;
    
    DKCircleButton* startButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    startButton.center = CGPointMake(([[UIScreen mainScreen] bounds].size.width / 2), ([[UIScreen mainScreen] bounds].size.height) / 2);
    
    startButton.titleLabel.font = FONT_BUTTON_APPLICATION_SEMI_BOLD;
    
    [startButton setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [startButton setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [startButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [startButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [startButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    [startButton.titleLabel setShadowOffset:CGSizeMake(0.5f, 1.0f)];
    
    [startButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [startButton setTitle:NSLocalizedString(@"Choose your video", nil) forState:UIControlStateSelected];
    [startButton setTitle:NSLocalizedString(@"Choose your video", nil) forState:UIControlStateHighlighted];
    
    [startButton setBorderColor:[UIColor whiteColor]];
    [startButton setBorderSize:5.0f];
    
    [startButton addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startButton];
    
    [startButton setPulsatingAnimation:YES];
    
    startButton = nil;

}

/*!
 * @discussion Start button action defined.
 * @param UIButton sender
 * @return IBAction
 */
-(IBAction)tapOnButton:(UIButton*)sender
{
    [self performSelector:@selector(pushTheVideoEditViewControllerIntoStackAfterButtonAnimation) withObject:nil afterDelay:.6];
}

-(void)pushTheVideoEditViewControllerIntoStackAfterButtonAnimation
{
    VideoEditorScreenViewController* videoEditorScreenVCObj = [[VideoEditorScreenViewController alloc]initWithNibName:@"VideoEditorScreenViewController" bundle:nil];
    [self.navigationController pushViewController:videoEditorScreenVCObj animated:YES];
    
//    NSURL* videoUrlForDemoVideoAsset = [[NSBundle mainBundle] URLForResource:@"SampleVideoForDemo" withExtension:@"mp4"];
//    UIImage* image = [UIHELPER loadImageForVideoWithUrl:videoUrlForDemoVideoAsset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
