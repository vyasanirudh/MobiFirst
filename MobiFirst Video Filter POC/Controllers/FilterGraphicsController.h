//
//  FilterGraphicsController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 13/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface FilterGraphicsController : NSObject
{
    GPUImageMovie *movieFile;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
}

@property (nonatomic, strong) NSArray* filterSelectionOptionsArray;

/*!
 * @discussion Returns a shared instance of the FilterGraphicsController Class.
 * @param nil
 * @return FilterGraphicsController *
 */
+ (FilterGraphicsController*) sharedInstance;

- (void) applyFilterForPreviewToImageView:(UIImageView*)imageViewForPreview andFilterType:(kSelectionType)filterType;

@end
