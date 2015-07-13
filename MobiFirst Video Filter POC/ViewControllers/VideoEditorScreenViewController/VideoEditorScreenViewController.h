//
//  VideoEditorScreenViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOSKnobControl.h"

@interface VideoEditorScreenViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView*   videoScreenCapImageView;

@property (nonatomic, weak) IBOutlet UIButton*      popOverControlButton;

@property (nonatomic, weak) IBOutlet UIView*        knobControlView_1;
@property (nonatomic, weak) IBOutlet UIView*        knobControlView_2;
@property (nonatomic, weak) IBOutlet UIView*        knobControlView_3;

@property (nonatomic, weak) IBOutlet UILabel*       selectedOptionLabel;

@property (nonatomic, strong) IOSKnobControl* knobControl_1;
@property (nonatomic, strong) IOSKnobControl* knobControl_2;
@property (nonatomic, strong) IOSKnobControl* knobControl_3;

-(IBAction)popOverControlButtonAction:(UIButton*)sender;

@end
