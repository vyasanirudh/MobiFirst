//
//  DocumentsDirectoryContentController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 14/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsDirectoryContentController : NSObject

/*!
 * @discussion Returns a shared instance of the DocumentsDirectoryContentController Class.
 * @param nil
 * @return DocumentsDirectoryContentController *
 */
+ (DocumentsDirectoryContentController*) sharedInstance;

@property (nonatomic, strong) NSMutableArray* videoFilesPresentInTheDirectory;
@property (nonatomic, strong) NSMutableArray* videoFilesPresentInTheDirectoryWithPath;

/*!
 * @discussion Scan through the documents directory for videos and store the path locally.
 * @param nil
 * @return nil
 */
- (void)startLookingForVideosInTheDocumentsDirectory;



@end
