//
//  VideoEditorScreenViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoEditorScreenViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView* videoScreenCapImageView;
@property (nonatomic, weak) IBOutlet UIButton*    popOverControlButton;

-(IBAction)popOverControlButtonAction:(UIButton*)sender;

@end
