//
//  VideoContentTableViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 14/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoContentTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView* videoContentTableView;

@end
