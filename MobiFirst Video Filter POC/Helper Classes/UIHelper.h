//
//  UIHelper.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    
    kPulsatingAnimationOptionScale,
    kPulsatingAnimationOptionFade
    
}kPulsatingAnimationOption;

@interface UIHelper : NSObject

/*!
 * @discussion Returns a shared instance of the UIHelper Class.
 * @param nil
 * @return UIHelper *
 */
+ (UIHelper*) sharedInstance;

/*!
 * @discussion Generates a screen cap for the video asset and returns a UIImage.
 * @param NSURL* videoUrl
 * @return UIImage*
 */
- (UIImage*)loadImageForVideoWithUrl:(NSURL*)videoUrl;

/*!
 * @discussion returns pulsating effect animation for various modes.
 * @param kPulsatingAnimationOption pulsatingOption
 * @return CABasicAnimation*
 */
- (CABasicAnimation*)pulsatingAnimationForAnimationOption:(kPulsatingAnimationOption)pulsatingOption;

@end
