//
//  VideoEditorScreenViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "VideoEditorScreenViewController.h"
#import "WYPopoverController.h"
#import "FilterSelectionViewController.h"

@interface VideoEditorScreenViewController ()<WYPopoverControllerDelegate>
{
    WYPopoverController* popOverControllerObj;
    CGAffineTransform popOverControlButtonOriginalTransform;
}

@end

@implementation VideoEditorScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* videoUrlForDemoVideoAsset = [[NSBundle mainBundle] URLForResource:@"SampleVideoForDemo" withExtension:@"mp4"];
    UIImage* image = [UIHELPER loadImageForVideoWithUrl:videoUrlForDemoVideoAsset];
    _videoScreenCapImageView.image = image;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    popOverControlButtonOriginalTransform = _popOverControlButton.transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

#pragma mark - Button Actions

-(IBAction)popOverControlButtonAction:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    
    [self buttonShouldAnimateForScale:sender.selected andButton:sender];
    
    [self showOrHidePopContainingFilterSelectionOptions:sender];
}

#pragma mark - Helper Method to add or remove Pop Over

-(void)showOrHidePopContainingFilterSelectionOptions:(UIButton*)sender
{
    if (popOverControllerObj == nil)
    {
        UIView* btn = (UIView*)sender;
        
        FilterSelectionViewController *settingsViewController = [[FilterSelectionViewController alloc]init];
        
        if ([settingsViewController respondsToSelector:@selector(setPreferredContentSize:)]) {
            settingsViewController.preferredContentSize = CGSizeMake(280, 280);             // iOS 7
        }
        else {
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated"
            settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);      // iOS < 7
#pragma clang diagnostic pop
        }
        
        settingsViewController.title = @"Filters";
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        settingsViewController.modalInPopover = NO;
        
        UINavigationController* contentViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        popOverControllerObj = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        popOverControllerObj.delegate = self;
        popOverControllerObj.passthroughViews = @[btn];
        popOverControllerObj.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        popOverControllerObj.wantsDefaultContentAppearance = NO;
        
        [popOverControllerObj presentPopoverFromRect:btn.bounds
                                              inView:btn
                            permittedArrowDirections:WYPopoverArrowDirectionAny
                                            animated:YES
                                             options:WYPopoverAnimationOptionFadeWithScale];
    }
    else
    {
        [self done:nil];
    }
}

#pragma mark - Selectors

- (void)done:(id)sender
{
    [popOverControllerObj dismissPopoverAnimated:YES];
    popOverControllerObj.delegate = nil;
    popOverControllerObj = nil;
    
    [_popOverControlButton setSelected:NO];
    [self buttonShouldAnimateForScale:NO andButton:_popOverControlButton];
}

#pragma mark - WYPopOverController Delegates

-(void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController
{
    popOverControllerObj.delegate = nil;
    popOverControllerObj = nil;
    
    [_popOverControlButton setSelected:NO];
    [self buttonShouldAnimateForScale:NO andButton:_popOverControlButton];
}

#pragma mark - Helper method to add or remove button animations

- (void) buttonShouldAnimateForScale:(BOOL)shouldAnimate andButton:(UIButton*)buttonToBeControlled
{
    if (shouldAnimate) {
        
        [buttonToBeControlled.layer addAnimation:[UIHELPER pulsatingAnimationForAnimationOption:kPulsatingAnimationOptionScale] forKey:nil];
    }
    else
    {
        [buttonToBeControlled.layer removeAllAnimations];
        buttonToBeControlled.transform = popOverControlButtonOriginalTransform;
    }
}


@end
