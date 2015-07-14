//
//  FilterGraphicsController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 13/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "FilterGraphicsController.h"

static FilterGraphicsController* sharedObject = nil;

@implementation FilterGraphicsController

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self populateTheFilterAvailableArray];
    }
    
    return self;
}

+(FilterGraphicsController *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedObject = [[FilterGraphicsController alloc] init];
        
    });
    return sharedObject;
}

-(void)applyFilterForPreviewToImageView:(GPUImageView *)imageViewForPreview andFilterType:(kSelectionType)filterType andImage:(UIImage*)selectedImage
{
    [self setFilterTypeForSettingsOrFilterSelectedType:filterType];
      
    sourcePicture = nil;
    
    sourcePicture = [[GPUImagePicture alloc] initWithImage:selectedImage smoothlyScaleOutput:YES];
    
    GPUImageView *imageView = (GPUImageView *)imageViewForPreview;
    
    [sourcePicture addTarget:filter];
    
    [filter addTarget:imageView];
    
    [sourcePicture processImage];
}

- (void)populateTheFilterAvailableArray
{
    NSArray* _localFilterArray = @[FILTER_POLKA,FILTER_CROSSHATCH,FILTER_SKETCH];
    NSArray* _localSettingsArray = @[SETTINGS_CONTRAST,SETTINGS_SATURATION,SETTINGS_BRIGHTNESS,SETTINGS_HUE,SETTINGS_RGB];
    
    _filterSelectionOptionsArray = @[_localFilterArray,_localSettingsArray];
    
    _localSettingsArray = nil;
    _localFilterArray = nil;
    
}

- (void)setFilterTypeForSettingsOrFilterSelectedType:(kSelectionType)selectedKey
{
    filter = nil;
    
    switch (selectedKey) {
            
        case kSelectionTypePolkaDot:
            
            filter = [self getPolkaDotFilterInstanceLazyly];
            
            break;
            
        case kSelectionTypeCrossHatch:
            
            filter = [self getMosaicFilterInstanceLazyly];
            
            break;
        case kSelectionTypeSketch:
            
            filter = [self getSketchFilterInstanceLazyly];
            
            break;
        case kSelectionTypeContrast:
            
            filter = [self getContrastFilterInstanceLazyly];
            
            break;
        case kSelectionTypeBrightness:
            
            filter = [self getBrightnessFilterInstanceLazyly];
            
            break;
        case kSelectionTypeSaturation:
            
            filter = [self getSaturationFilterInstanceLazyly];
            
            break;
        case kSelectionTypeHue:
            
            filter = [self getHueFilterInstanceLazyly];
            
            break;
        case kSelectionTypeRGB:
            
            filter = [self getRGBFilterInstanceLazyly];
            
            break;
        default:
            break;
    }
}

- (GPUImageOutput<GPUImageInput> *)getPolkaDotFilterInstanceLazyly
{
    if (!filterPolkaDot) {
        
        filterPolkaDot = [[GPUImagePolkaDotFilter alloc] init];
        
    }
    
    return filterPolkaDot;
}

- (GPUImageOutput<GPUImageInput> *)getMosaicFilterInstanceLazyly
{
    if (!filterCrossHatch) {
        
        filterCrossHatch = [[GPUImageCrosshatchFilter alloc] init];
        
    }
    
    return filterCrossHatch;
}

- (GPUImageOutput<GPUImageInput> *)getSketchFilterInstanceLazyly
{
    if (!filterSketch) {
        
        filterSketch = [[GPUImageSketchFilter alloc] init];
    }
    
    return filterSketch;
}

- (GPUImageOutput<GPUImageInput> *)getContrastFilterInstanceLazyly
{
    if (!filterContrast) {
        
        filterContrast = [[GPUImageContrastFilter alloc] init];
        
    }
    
    return filterContrast;
}

- (GPUImageOutput<GPUImageInput> *)getBrightnessFilterInstanceLazyly
{
    if (!filterBrightness) {
        
        filterBrightness = [[GPUImageBrightnessFilter alloc] init];
        
    }
    
    return filterBrightness;
}

- (GPUImageOutput<GPUImageInput> *)getSaturationFilterInstanceLazyly
{
    if (!filterSaturation) {
        
        filterSaturation = [[GPUImageSaturationFilter alloc] init];
        
    }
    
    return filterSaturation;
}

- (GPUImageOutput<GPUImageInput> *)getHueFilterInstanceLazyly
{
    if (!filterHue) {
        
        filterHue = [[GPUImageHueFilter alloc] init];
        
    }
    
    return filterHue;
}

- (GPUImageOutput<GPUImageInput> *)getRGBFilterInstanceLazyly
{
    if (!filterRGB) {
        
        filterRGB = [[GPUImageRGBFilter alloc] init];
        
    }
    
    return filterRGB;
}

- (kSelectionType) getTypeForFilterName:(NSString*)filterName
{
    if ([filterName isEqualToString:FILTER_POLKA]) {
        
        return kSelectionTypePolkaDot;
        
    } else if ([filterName isEqualToString:FILTER_CROSSHATCH])
    {
        return kSelectionTypeCrossHatch;
    }
    else if ([filterName isEqualToString:FILTER_SKETCH])
    {
        return kSelectionTypeSketch;
        
    } else if ([filterName isEqualToString:SETTINGS_BRIGHTNESS])
    {
        return kSelectionTypeBrightness;
        
    } else if ([filterName isEqualToString:SETTINGS_CONTRAST])
    {
        return kSelectionTypeContrast;
        
    } else if ([filterName isEqualToString:SETTINGS_SATURATION])
    {
        return kSelectionTypeSaturation;
        
    } else if ([filterName isEqualToString:SETTINGS_HUE])
    {
        return kSelectionTypeHue;
        
    } else
    {
        return kSelectionTypeRGB;
    }
}

-(void)changeValueAccordingToRedSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageRGBFilter class]]) {
        
        [(GPUImageRGBFilter *)filter setRed:value];
        
        [sourcePicture processImage];
    }
}

-(void)changeValueAccordingToGreenSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageRGBFilter class]]) {
        
        [(GPUImageRGBFilter *)filter setGreen:value];
        
        [sourcePicture processImage];
    }
}

-(void)changeValueAccordingToBlueSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageRGBFilter class]]) {
        
        [(GPUImageRGBFilter *)filter setBlue:value];
        
        [sourcePicture processImage];
    }
}

-(void)changeValueAccordingToGenericSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageContrastFilter class]]) {
     
        [(GPUImageContrastFilter *)filter setContrast:value];
        
        [sourcePicture processImage];
        
    } else if ([filter isKindOfClass:[GPUImageBrightnessFilter class]]) {
        
        [(GPUImageBrightnessFilter *)filter setBrightness:value];
        
        [sourcePicture processImage];
    } else if ([filter isKindOfClass:[GPUImageSaturationFilter class]]) {
        
        [(GPUImageSaturationFilter *)filter setSaturation:value];
        
        [sourcePicture processImage];
    } else if ([filter isKindOfClass:[GPUImageHueFilter class]]) {
        
        [(GPUImageHueFilter *)filter setHue:value];
        
        [sourcePicture processImage];
    } else if ([filter isKindOfClass:[GPUImagePolkaDotFilter class]]) {
        
        [(GPUImagePolkaDotFilter *)filter setDotScaling:value];
        
        [sourcePicture processImage];
    } else if ([filter isKindOfClass:[GPUImageCrosshatchFilter class]]) {
        
        [(GPUImageCrosshatchFilter *)filter setCrossHatchSpacing:value];
        
        [sourcePicture processImage];
    } else if ([filter isKindOfClass:[GPUImageSketchFilter class]]) {
        
        [sourcePicture processImage];
    }
}

-(void)applyFilterToVideoToView:(GPUImageView *)imageViewForPreview
{
    NSURL* videoUrlForDemoVideoAsset = [[NSBundle mainBundle] URLForResource:@"SampleVideoForDemo" withExtension:@"mp4"];
    
    movieFile = [[GPUImageMovie alloc] initWithURL:videoUrlForDemoVideoAsset];
    movieFile.runBenchmark = YES;
    movieFile.playAtActualSpeed = NO;
    
    [movieFile addTarget:filter];
    
    // Only rotate the video for display, leave orientation the same for recording
    GPUImageView *filterView = (GPUImageView *)imageViewForPreview;
    [filter addTarget:filterView];
    
    // In addition to displaying to the screen, write out a processed version of the movie to disk
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",[self getVideoFileNameForVideoWithTimeStamp]]];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 368.0)];
    [filter addTarget:movieWriter];
    
    // Configure this for video from the movie file, where we want to preserve all video frames and audio samples
    movieWriter.shouldPassthroughAudio = YES;
    movieFile.audioEncodingTarget = movieWriter;
    [movieFile enableSynchronizedEncodingUsingMovieWriter:movieWriter];
    
    [movieWriter setDelegate:self];
    
    [movieWriter startRecording];
    [movieFile startProcessing];
}

- (void)movieRecordingCompleted
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MOVIE_CONVERSION_COMPLETE_NOTIFICATION object:nil];
}

- (void)movieRecordingFailedWithError:(NSError*)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MOVIE_CONVERSION_FAILED_NOTIFICATION object:nil];
}

-(NSString*)getVideoFileNameForVideoWithTimeStamp
{
    NSDate *localDate = [NSDate date];

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"HH:mm:ss";
    
    
    NSString *timeString = [timeFormatter stringFromDate: localDate];
    
    NSString* videoFileName = [NSString stringWithFormat:@"MobiFirst_%@.mp4",timeString];
    
    timeString = nil;
    timeFormatter = nil;
    localDate = nil;
    
    return videoFileName;
}


@end
