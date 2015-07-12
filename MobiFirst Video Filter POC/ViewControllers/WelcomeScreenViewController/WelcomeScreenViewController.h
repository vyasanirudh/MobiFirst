//
//  WelcomeScreenViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 10/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#import "DKCircleButton.h"

@interface WelcomeScreenViewController : UIViewController

@property (nonatomic, weak) IBOutlet FXBlurView*        blurredOverlayMainView;
@property (nonatomic, weak) IBOutlet UIImageView*       backgroundImageViewForBlurredImageView;

@end

