//
//  FilterSelectionViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "FilterSelectionViewController.h"

@interface FilterSelectionViewController ()

@end

@implementation FilterSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat _preferredContentHeightForSelf = self.preferredContentSize.height;
    
    _preferredContentHeightForSelf = _preferredContentHeightForSelf - self.navigationController.navigationBar.frame.size.height;
    
    CGRect _rectForFilterSelectionOptionTableView = CGRectMake(0, 0, 280, _preferredContentHeightForSelf);
    
    _filterSelectionOptionTableView = [[UITableView alloc]initWithFrame:_rectForFilterSelectionOptionTableView];
    _filterSelectionOptionTableView.delegate = self;
    _filterSelectionOptionTableView.dataSource = self;
    
    [self.view addSubview:_filterSelectionOptionTableView];
    
    // Do any additional setup after loading the view.
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell" forIndexPath:indexPath];
    
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WYSettingsTableViewCell"];
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    cell.textLabel.text = @"Compression";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
