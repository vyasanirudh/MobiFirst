//
//  VideoContentTableViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 14/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "VideoContentTableViewController.h"
#import "DocumentsDirectoryContentController.h"
#import "VideoPlayerViewController.h"

@interface VideoContentTableViewController ()

@end

@implementation VideoContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = TEXT_NAVIGATION_BAR_TITLE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
     return [[DOCUMENTS_FINDER_CONTROLLER_OBJECT videoFilesPresentInTheDirectory] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"VideoContentTableCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoContentTableCell"];
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    
    DocumentsDirectoryContentController* documentsControllerSharedLocalCopy = DOCUMENTS_FINDER_CONTROLLER_OBJECT;
    
    NSString* textForCellTitle = [[documentsControllerSharedLocalCopy videoFilesPresentInTheDirectory] objectAtIndex:indexPath.row];
    cell.textLabel.text = textForCellTitle;
    
    textForCellTitle = nil;
    
    documentsControllerSharedLocalCopy = nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocumentsDirectoryContentController* documentsControllerSharedLocalCopy = DOCUMENTS_FINDER_CONTROLLER_OBJECT;
    NSString* videoUrlString = [[documentsControllerSharedLocalCopy videoFilesPresentInTheDirectoryWithPath] objectAtIndex:indexPath.row];
    
    VideoPlayerViewController* videoPlayerLocalObj = [[VideoPlayerViewController alloc]init];
    [videoPlayerLocalObj setVideoPlayBackRequestString:videoUrlString];
    
    [self.navigationController pushViewController:videoPlayerLocalObj animated:YES];
    
    videoUrlString = nil;
    videoPlayerLocalObj = nil;
}


@end
