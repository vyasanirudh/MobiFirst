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
#import "DocumentsDirectoryContentController.h"
#import "VideoContentTableViewController.h"

@interface WelcomeScreenViewController ()
{
    DKCircleButton* startButton;
    DKCircleButton* viewVideoFilesButton;
}
@end

@implementation WelcomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setUpButtonForView];
}

/*!
 * @discussion Setup the view initially. Adding sub views to view controller. Private Method.
 * @param void
 * @return void
 */
-(void)setUpButtonForView
{
    
    self.navigationItem.title = TEXT_NAVIGATION_BAR_TITLE;
    
    if (!startButton) {
        
        startButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        
        startButton.center = CGPointMake(([[UIScreen mainScreen] bounds].size.width / 2), ([[UIScreen mainScreen] bounds].size.height) / 2 - 60);
        
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

    }
    
    if (!viewVideoFilesButton) {
        
        viewVideoFilesButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        
        viewVideoFilesButton.center = CGPointMake(([[UIScreen mainScreen] bounds].size.width / 2), ([[UIScreen mainScreen] bounds].size.height) / 2 + 100 );
        
        viewVideoFilesButton.titleLabel.font = FONT_VIEW_BUTTON_APPLICATION_SEMI_BOLD;
        
        [viewVideoFilesButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [viewVideoFilesButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [viewVideoFilesButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
        [viewVideoFilesButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [viewVideoFilesButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [viewVideoFilesButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
        [viewVideoFilesButton.titleLabel setShadowOffset:CGSizeMake(0.5f, 1.0f)];
        
        [viewVideoFilesButton setTitle:NSLocalizedString(@"View Videos", nil) forState:UIControlStateNormal];
        [viewVideoFilesButton setTitle:NSLocalizedString(@"View Videos", nil) forState:UIControlStateSelected];
        [viewVideoFilesButton setTitle:NSLocalizedString(@"View Videos", nil) forState:UIControlStateHighlighted];
        
        [viewVideoFilesButton setBorderColor:[UIColor darkGrayColor]];
        [viewVideoFilesButton setBorderSize:5.0f];
        
        [viewVideoFilesButton addTarget:self action:@selector(tapOnViewButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:viewVideoFilesButton];
    }
    
    [startButton setPulsatingAnimation:YES];
    [DOCUMENTS_FINDER_CONTROLLER_OBJECT startLookingForVideosInTheDocumentsDirectory];
    
    if ([[DOCUMENTS_FINDER_CONTROLLER_OBJECT videoFilesPresentInTheDirectory] count] > 0) {
        
        [viewVideoFilesButton setPulsatingAnimation:YES];
        [viewVideoFilesButton setEnabled:YES];
    }
    else
    {
        [viewVideoFilesButton setEnabled:NO];
        [viewVideoFilesButton setPulsatingAnimation:NO];
    }
}

/*!
 * @discussion Start button action defined.
 * @param UIButton sender
 * @return IBAction
 */
-(IBAction)tapOnButton:(UIButton*)sender
{
    [self performSelector:@selector(pushTheVideoEditViewControllerIntoStackAfterButtonAnimation) withObject:nil afterDelay:.4];
}

/*!
 * @discussion View button action defined.
 * @param UIButton sender
 * @return IBAction
 */
-(IBAction)tapOnViewButton:(UIButton*)sender
{
    [self performSelector:@selector(pushTheDirectoryContentViewControllerIntoStackAfterButtonAnimation) withObject:nil afterDelay:.4];
    
}

-(void)pushTheDirectoryContentViewControllerIntoStackAfterButtonAnimation
{
    VideoContentTableViewController* videoContentScreenVCObj = [[VideoContentTableViewController alloc]initWithNibName:@"VideoContentTableViewController" bundle:nil];
    [self.navigationController pushViewController:videoContentScreenVCObj animated:YES];
}

-(void)pushTheVideoEditViewControllerIntoStackAfterButtonAnimation
{
    VideoEditorScreenViewController* videoEditorScreenVCObj = [[VideoEditorScreenViewController alloc]initWithNibName:@"VideoEditorScreenViewController" bundle:nil];
    [self.navigationController pushViewController:videoEditorScreenVCObj animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
