//
//  UIHelper.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "UIHelper.h"
#import <AVFoundation/AVFoundation.h>

static UIHelper* sharedObject = nil;

@implementation UIHelper

+(UIHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedObject = [[UIHelper alloc] init];
        
    });
    return sharedObject;
}

- (UIImage*)loadImageForVideoWithUrl:(NSURL*)videoUrl {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    
    UIImage* imageFromGCImageRef = [[UIImage alloc] initWithCGImage:imgRef];
    
    return imageFromGCImageRef;
    
}

- (CABasicAnimation*)pulsatingAnimationForAnimationOption:(kPulsatingAnimationOption)pulsatingOption
{
    CABasicAnimation *theAnimation;
    
    switch (pulsatingOption) {
        case kPulsatingAnimationOptionFade:

            theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
            
            theAnimation.duration=1.0;
            theAnimation.repeatCount=HUGE_VALF;
            theAnimation.autoreverses=YES;
            theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
            theAnimation.toValue=[NSNumber numberWithFloat:0.0];

            break;
            
        case kPulsatingAnimationOptionScale:
            
            
            theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            theAnimation.duration=1.0;
            theAnimation.repeatCount=HUGE_VALF;
            theAnimation.autoreverses=YES;
            theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
            theAnimation.toValue=[NSNumber numberWithFloat:0.5];
            
       default:
            break;
    }
    
    
    return theAnimation;
}

@end
