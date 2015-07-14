//
//  DocumentsDirectoryContentController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 14/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "DocumentsDirectoryContentController.h"

static DocumentsDirectoryContentController* sharedObject = nil;

@implementation DocumentsDirectoryContentController

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _videoFilesPresentInTheDirectory = [[NSMutableArray alloc]initWithCapacity:0];
        _videoFilesPresentInTheDirectoryWithPath = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return self;
}

+(DocumentsDirectoryContentController *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedObject = [[DocumentsDirectoryContentController alloc] init];
        
    });
    return sharedObject;
}


- (void)startLookingForVideosInTheDocumentsDirectory
{
    [_videoFilesPresentInTheDirectory removeAllObjects];
    [_videoFilesPresentInTheDirectoryWithPath removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory  error:nil];
    
    for ( NSString *apath in filePathsArray )
    {
        NSString *fullpath;
        fullpath = [documentsDirectory stringByAppendingPathComponent:apath];
        [_videoFilesPresentInTheDirectory addObject:apath];
        [_videoFilesPresentInTheDirectoryWithPath addObject:fullpath];
        fullpath = nil;
    }
}

@end
