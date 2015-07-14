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
#import "UIView+Toast.h"

@interface VideoEditorScreenViewController ()<WYPopoverControllerDelegate,FilterSelectionDelegate>
{
    WYPopoverController* popOverControllerObj;
    CGAffineTransform popOverControlButtonOriginalTransform;
}

@end

@implementation VideoEditorScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = TEXT_NAVIGATION_BAR_TITLE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    NSURL* videoUrlForDemoVideoAsset = [[NSBundle mainBundle] URLForResource:@"SampleVideoForDemo" withExtension:@"mp4"];
    UIImage* image = [UIHELPER loadImageForVideoWithUrl:videoUrlForDemoVideoAsset];
    _videoScreenCapImageView.image = image;
    
    [_selectedFilterImageView setHidden:YES];
    
    [_applyToVideoButton setEnabled:NO];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    popOverControlButtonOriginalTransform = _popOverControlButton.transform;
    
    [self addObserverForNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self removeObserverForNotifications];
}

#pragma mark - Button Actions

-(IBAction)popOverControlButtonAction:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    
    [self buttonShouldAnimateForScale:sender.selected andButton:sender];
    
    [self showOrHidePopContainingFilterSelectionOptions:sender];
}

-(IBAction)applyToVideoButtonAction:(UIButton *)sender
{
    [_applyToVideoButton setEnabled:NO];
        
    FilterGraphicsController* localFilterControllerObj = FILTER_GRAPHICS_CONTROLLER_OBJECT;
    
    [localFilterControllerObj applyFilterToVideoToView:_selectedFilterImageView];
    
    localFilterControllerObj = nil;
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

    [_applyToVideoButton setEnabled:YES];
    
    FilterGraphicsController* localFilterControllerObj = FILTER_GRAPHICS_CONTROLLER_OBJECT;
    
    [self setSliderMinMaxAndCurrentValuesForType:filterType];
    
    [localFilterControllerObj applyFilterForPreviewToImageView:_selectedFilterImageView andFilterType:filterType andImage:_videoScreenCapImageView.image];
    
    localFilterControllerObj = nil;
}

- (void)setSliderMinMaxAndCurrentValuesForType:(kSelectionType)filterType
{
    switch (filterType) {
            
        case kSelectionTypePolkaDot:
            
            [_genericSliderOutlet setMaximumValue:1.0f];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:.9f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
            
        case kSelectionTypeCrossHatch:
            
            [_genericSliderOutlet setMaximumValue:1.0f];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:.03f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
        case kSelectionTypeSketch:
            
            [_genericSliderOutlet setMaximumValue:15.30f];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:0.0];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:NO];
            
            break;
        case kSelectionTypeContrast:
            
            [_genericSliderOutlet setMaximumValue:4.0f];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:1.0f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
        case kSelectionTypeBrightness:
            
            [_genericSliderOutlet setMaximumValue:1.0f];
            [_genericSliderOutlet setMinimumValue:-1.0f];
            [_genericSliderOutlet setValue:0.0f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
        case kSelectionTypeSaturation:
            
            [_genericSliderOutlet setMaximumValue:2.0f];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:1.0f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
        case kSelectionTypeHue:
            
            [_genericSliderOutlet setMaximumValue:360.];
            [_genericSliderOutlet setMinimumValue:0.0f];
            [_genericSliderOutlet setValue:0.0f];
            
            [_redSliderOutlet setEnabled:NO];
            [_greenSliderOutlet setEnabled:NO];
            [_blueSliderOutlet setEnabled:NO];
            [_genericSliderOutlet setEnabled:YES];
            
            break;
        case kSelectionTypeRGB:
            
            [_redSliderOutlet setEnabled:YES];
            [_greenSliderOutlet setEnabled:YES];
            [_blueSliderOutlet setEnabled:YES];
            [_genericSliderOutlet setEnabled:NO];
            
            [_redSliderOutlet setMaximumValue:255.0f];
            [_redSliderOutlet setMinimumValue:0.0f];
            [_redSliderOutlet setValue:0.0f];
            
            [_greenSliderOutlet setMaximumValue:255.0f];
            [_greenSliderOutlet setMinimumValue:0.0f];
            [_greenSliderOutlet setValue:0.0f];
            
            [_blueSliderOutlet setMaximumValue:255.0f];
            [_blueSliderOutlet setMinimumValue:0.0f];
            [_blueSliderOutlet setValue:0.0f];
            
            break;
        default:
            break;
    }
}

- (void)addObserverForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCompletionAlert) name:MOVIE_CONVERSION_COMPLETE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFailedAlert) name:MOVIE_CONVERSION_FAILED_NOTIFICATION object:nil];
}

- (void)removeObserverForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MOVIE_CONVERSION_COMPLETE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MOVIE_CONVERSION_FAILED_NOTIFICATION object:nil];
}

- (void)showCompletionAlert
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_selectedOptionLabel setText:@"Choose Filters or Settings:"];
        [_applyToVideoButton setEnabled:NO];
        
        [self.view makeToast:@"Filter applied to video successfully and saved. You can view the same from the previous screen."];
    });
   
}

- (void)showFailedAlert
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_selectedOptionLabel setText:@"Choose Filters or Settings:"];
        [_applyToVideoButton setEnabled:NO];
        
        [self.view makeToast:@"The conversion of the video failed!"];
    });
}

@end
