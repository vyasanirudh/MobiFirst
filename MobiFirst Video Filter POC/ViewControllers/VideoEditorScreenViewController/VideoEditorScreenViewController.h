//
//  VideoEditorScreenViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOSKnobControl.h"
#import "GPUImage.h"

@interface VideoEditorScreenViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView*        videoScreenCapImageView;

@property (nonatomic, weak) IBOutlet UIButton*           popOverControlButton;

@property (nonatomic, weak) IBOutlet UILabel*            selectedOptionLabel;

@property (nonatomic, weak) IBOutlet GPUImageView*       selectedFilterImageView;

@property (nonatomic, weak) IBOutlet UISlider*           genericSliderOutlet;
@property (nonatomic, weak) IBOutlet UISlider*           redSliderOutlet;
@property (nonatomic, weak) IBOutlet UISlider*           greenSliderOutlet;
@property (nonatomic, weak) IBOutlet UISlider*           blueSliderOutlet;

-(IBAction)popOverControlButtonAction:(UIButton*)sender;

-(IBAction)sliderValueChanged:(UISlider*)slider;

@end
