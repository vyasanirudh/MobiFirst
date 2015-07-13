//
//  FilterGraphicsController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 13/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"
#import "VideoEditorScreenViewController.h"

@interface FilterGraphicsController : NSObject
{
    GPUImageMovie *movieFile;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    
    GPUImagePolkaDotFilter* filterPolkaDot;
    GPUImageLowPassFilter* filterLowPass;
    GPUImageKuwaharaFilter* filterKuwahara;
    GPUImageContrastFilter* filterContrast;
    GPUImageBrightnessFilter* filterBrightness;
    GPUImageSaturationFilter* filterSaturation;
    GPUImageHueFilter* filterHue;
    GPUImageRGBFilter* filterRGB;
}

@property (nonatomic, strong) NSArray* filterSelectionOptionsArray;

/*!
 * @discussion Returns a shared instance of the FilterGraphicsController Class.
 * @param nil
 * @return FilterGraphicsController *
 */
+ (FilterGraphicsController*) sharedInstance;

- (void) applyFilterForPreviewToImageView:(GPUImageView*)imageViewForPreview andFilterType:(kSelectionType)filterType andImage:(UIImage*)selectedImage;

- (kSelectionType) getTypeForFilterName:(NSString*)filterName;

- (void)changeValueAccordingToRedSlider:(float)value;
- (void)changeValueAccordingToGreenSlider:(float)value;
- (void)changeValueAccordingToBlueSlider:(float)value;
- (void)changeValueAccordingToGenericSlider:(float)value;

@end
