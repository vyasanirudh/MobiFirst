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

-(void)applyFilterForPreviewToImageView:(UIImageView *)imageViewForPreview andFilterType:(kSelectionType)filterType
{
    
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

- (void)setFilterTypeForSettingsOrFilterSelected:(NSString*)selectedKey
{
    
}

@end
