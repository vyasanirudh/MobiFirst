//
//  Constants.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#ifndef MobiFirst_Video_Filter_POC_Constants_h
#define MobiFirst_Video_Filter_POC_Constants_h

#import "UIHelper.h"

/*Fonts*/
#define FONT_NAVIGATION_BAR_APPLICATION_BOLD     [UIFont fontWithName:@"ProximaNova-Bold" size:20.0f]
#define FONT_NAVIGATION_BAR_APPLICATION_LIGHT    [UIFont fontWithName:@"ProximaNova-Bold" size:20.0f]
#define FONT_BUTTON_APPLICATION_SEMI_BOLD        [UIFont fontWithName:@"ProximaNova-SemiBold" size:28.0f];
#define FONT_VIEW_BUTTON_APPLICATION_SEMI_BOLD   [UIFont fontWithName:@"ProximaNova-SemiBold" size:20.0f];

/*Text*/
#define TEXT_NAVIGATION_BAR_TITLE               @"Video Fun!"

/*Shared Instance defines*/
#define UIHELPER                                [UIHelper sharedInstance]
#define FILTER_GRAPHICS_CONTROLLER_OBJECT       [FilterGraphicsController sharedInstance]
#define DOCUMENTS_FINDER_CONTROLLER_OBJECT      [DocumentsDirectoryContentController sharedInstance]

/*Filter Strings*/
#define FILTER_POLKA                              @"Polka Dot Filter"
#define FILTER_CROSSHATCH                         @"Cross Hatch Filter"
#define FILTER_SKETCH                             @"Pencil Sketch"
#define SETTINGS_CONTRAST                         @"Contrast"
#define SETTINGS_SATURATION                       @"Saturation"
#define SETTINGS_BRIGHTNESS                       @"Brightness"
#define SETTINGS_HUE                              @"Hue"
#define SETTINGS_RGB                              @"RGB"

/*Notification Posted*/
#define MOVIE_CONVERSION_COMPLETE_NOTIFICATION    @"movie_recording_completed"
#define MOVIE_CONVERSION_FAILED_NOTIFICATION      @"movie_recording_failed"


#endif
