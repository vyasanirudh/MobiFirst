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
    
    [self setUpTheKnobViews];
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

#pragma mark - Helper method to setup the knob views

-(void) setUpTheKnobViews
{
    self.knobControl_1 = [[IOSKnobControl alloc] initWithFrame:self.knobControlView_1.bounds];
    self.knobControl_1.mode = IKCModeContinuous;
    self.knobControl_1.shadowOpacity = 1.0;
    self.knobControl_1.clipsToBounds = NO;
    // NOTE: This is an important optimization when using a custom circular knob image with a shadow.
    self.knobControl_1.knobRadius = 0.475 * self.knobControl_1.bounds.size.width;
    
    [self.knobControl_1 setTintColor:[UIColor lightGrayColor]];
    
    [self.knobControl_1 setTag:100];
    
    // arrange to be notified whenever the knob turns
    [self.knobControl_1 addTarget:self action:@selector(knobPositionChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Now hook it up to the demo
    [self.knobControlView_1 addSubview:self.knobControl_1];
    
    self.knobControl_2 = [[IOSKnobControl alloc] initWithFrame:self.knobControlView_2.bounds];
    self.knobControl_2.mode = IKCModeContinuous;
    self.knobControl_2.shadowOpacity = 1.0;
    self.knobControl_2.clipsToBounds = NO;
    // NOTE: This is an important optimization when using a custom circular knob image with a shadow.
    self.knobControl_2.knobRadius = 0.475 * self.knobControl_2.bounds.size.width;
    
    [self.knobControl_2 setTintColor:[UIColor lightGrayColor]];
    
    [self.knobControl_2 setTag:101];
    
    // arrange to be notified whenever the knob turns
    [self.knobControl_2 addTarget:self action:@selector(knobPositionChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Now hook it up to the demo
    [self.knobControlView_2 addSubview:self.knobControl_2];
    
    self.knobControl_3 = [[IOSKnobControl alloc] initWithFrame:self.knobControlView_3.bounds];
    self.knobControl_3.mode = IKCModeContinuous;
    self.knobControl_3.shadowOpacity = 1.0;
    self.knobControl_3.clipsToBounds = NO;
    // NOTE: This is an important optimization when using a custom circular knob image with a shadow.
    self.knobControl_3.knobRadius = 0.475 * self.knobControl_3.bounds.size.width;
    
    [self.knobControl_3 setTintColor:[UIColor lightGrayColor]];
    
    [self.knobControl_3 setTag:102];
    
    // arrange to be notified whenever the knob turns
    [self.knobControl_3 addTarget:self action:@selector(knobPositionChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.knobControlView_3 addSubview:self.knobControl_3];

    [self updateKnobProperties];
}

#pragma mark - Knob control callback
- (void)knobPositionChanged:(IOSKnobControl*)sender
{
    
}

- (void)updateKnobProperties
{
    self.knobControl_1.circular = YES;
    self.knobControl_1.min = 0;
    self.knobControl_1.max = 100;
    self.knobControl_1.clockwise = YES;
    self.knobControl_1.position = self.knobControl_1.position;
    
    self.knobControl_2.circular = YES;
    self.knobControl_2.min = 0;
    self.knobControl_2.max = 100;
    self.knobControl_2.clockwise = YES;
    self.knobControl_2.position = self.knobControl_2.position;
    
    self.knobControl_3.circular = YES;
    self.knobControl_3.min = 0;
    self.knobControl_3.max = 100;
    self.knobControl_3.clockwise = YES;
    self.knobControl_3.position = self.knobControl_3.position;
}

#pragma mark - Filter Selection Delegate Implementation

-(void)filterSelectionTableTappedOnCellWithTitle:(NSString *)filterOrSettingSelectedString
{
    __weak typeof(self) this = self;
    
    [popOverControllerObj dismissPopoverAnimated:YES completion:^{
       
        popOverControllerObj.delegate = nil;
        popOverControllerObj = nil;
        
        [_popOverControlButton setSelected:NO];
        [this buttonShouldAnimateForScale:NO andButton:_popOverControlButton];
        
    }];
    [_selectedOptionLabel setText:filterOrSettingSelectedString];
}

@end
