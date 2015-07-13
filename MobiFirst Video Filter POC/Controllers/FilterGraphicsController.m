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
    
    GPUImagePicture *sourcePicture = [[GPUImagePicture alloc] initWithImage:selectedImage smoothlyScaleOutput:YES];
    
    GPUImageView *imageView = (GPUImageView *)imageViewForPreview;
//    [filter forceProcessingAtSize:imageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
    [sourcePicture addTarget:filter];
    
    [filter addTarget:imageView];
    
    [sourcePicture processImage];
}

-(void)setTheCorrectFilterForTheFilterType:(kSelectionType)filterType
{
//    switch (filterType) {
//        case kFilterType1:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
}

- (void)populateTheFilterAvailableArray
{
    NSArray* _localFilterArray = @[FILTER_POLKA,FILTER_MOSAIC,FILTER_KAWAHARA];
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
            
        case kSelectionTypeMosaic:
            
            filter = [self getMosaicFilterInstanceLazyly];
            
            break;
        case kSelectionTypeKawahara:
            
            filter = [self getKuwaharaFilterInstanceLazyly];
            
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
    if (!filterLowPass) {
        
        filterLowPass = [[GPUImageLowPassFilter alloc] init];
        
    }
    
    return filterLowPass;
}

- (GPUImageOutput<GPUImageInput> *)getKuwaharaFilterInstanceLazyly
{
    if (!filterKuwahara) {
        
        filterKuwahara = [[GPUImageKuwaharaFilter alloc] init];
        filterKuwahara.radius = 15;
        
    }
    
    return filterKuwahara;
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
        
    } else if ([filterName isEqualToString:FILTER_MOSAIC])
    {
        return kSelectionTypeMosaic;
    }
    else if ([filterName isEqualToString:FILTER_KAWAHARA])
    {
        return kSelectionTypeKawahara;
        
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
        
    }
}

-(void)changeValueAccordingToGreenSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageRGBFilter class]]) {
        
        [(GPUImageRGBFilter *)filter setGreen:value];
    }
}

-(void)changeValueAccordingToBlueSlider:(float)value
{
    if ([filter isKindOfClass:[GPUImageRGBFilter class]]) {
        
        [(GPUImageRGBFilter *)filter setBlue:value];
    }
}

-(void)changeValueAccordingToGenericSlider:(float)value
{
    
}

@end
