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
#import "FilterGraphicsController.h"

@interface VideoEditorScreenViewController ()<WYPopoverControllerDelegate,FilterSelectionDelegate>
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
    
    [_selectedFilterImageView setHidden:YES];
    
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
        
        [settingsViewController setFilterSelectionDelegate:self];
        
        if ([settingsViewController respondsToSelector:@selector(setPreferredContentSize:)]) {
            settingsViewController.preferredContentSize = CGSizeMake(280, 280);             // iOS 7
        }
        else {
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated"
            settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);      // iOS < 7
#pragma clang diagnostic pop
        }
        
        settingsViewController.title = @"Filters and Settings";
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

#pragma mark - Knob control callback
- (IBAction)sliderValueChanged:(UISlider *)slider
{
    FilterGraphicsController* localFilterControllerObj = FILTER_GRAPHICS_CONTROLLER_OBJECT;
    
    if (slider.tag == 100) {
        
        [localFilterControllerObj changeValueAccordingToRedSlider:slider.value];
        
    } else if (slider.tag == 101)
    {
        [localFilterControllerObj changeValueAccordingToGreenSlider:slider.value];
        
    } else if (slider.tag == 102)
    {
        [localFilterControllerObj changeValueAccordingToBlueSlider:slider.value];
        
    } else if (slider.tag == 103)
    {
        [localFilterControllerObj changeValueAccordingToGenericSlider:slider.value];
        
    }
    
    localFilterControllerObj = nil;
}




#pragma mark - Filter Selection Delegate Implementation

-(void)filterSelectionTableTappedOnCellWithTitle:(NSString *)filterOrSettingSelectedString andFilterType:(kSelectionType)filterType
{
    __weak typeof(self) this = self;
    
    [popOverControllerObj dismissPopoverAnimated:YES completion:^{
       
        popOverControllerObj.delegate = nil;
        popOverControllerObj = nil;
        
        [_popOverControlButton setSelected:NO];
        [this buttonShouldAnimateForScale:NO andButton:_popOverControlButton];
        
    }];
    
    [_selectedOptionLabel setText:filterOrSettingSelectedString];
    
    [_videoScreenCapImageView setHidden:YES];
    [_selectedFilterImageView setHidden:NO];

    FilterGraphicsController* localFilterControllerObj = FILTER_GRAPHICS_CONTROLLER_OBJECT;
    
    [localFilterControllerObj applyFilterForPreviewToImageView:_selectedFilterImageView andFilterType:filterType andImage:_videoScreenCapImageView.image];
    
    localFilterControllerObj = nil;
}

@end
