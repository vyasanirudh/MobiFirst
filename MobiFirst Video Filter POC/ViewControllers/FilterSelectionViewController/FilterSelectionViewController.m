//
//  FilterSelectionViewController.m
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import "FilterSelectionViewController.h"
#import "FilterGraphicsController.h"

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
    return [[FILTER_GRAPHICS_CONTROLLER_OBJECT filterSelectionOptionsArray] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"Filters";
    }
    else
    {
        return @"Settings";
    }
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [[[FILTER_GRAPHICS_CONTROLLER_OBJECT filterSelectionOptionsArray] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"FilterSelectionCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterSelectionCell"];
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    
    FilterGraphicsController* filterGraphicsSharedLocalCopy = FILTER_GRAPHICS_CONTROLLER_OBJECT;
    
    NSString* textForCellTitle = [[[filterGraphicsSharedLocalCopy filterSelectionOptionsArray] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = textForCellTitle;
    
    textForCellTitle = nil;
    
    filterGraphicsSharedLocalCopy = nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.filterSelectionDelegate respondsToSelector:@selector(filterSelectionTableTappedOnCellWithTitle:andFilterType:)]) {
        [self.filterSelectionDelegate filterSelectionTableTappedOnCellWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text andFilterType:[FILTER_GRAPHICS_CONTROLLER_OBJECT getTypeForFilterName:[tableView cellForRowAtIndexPath:indexPath].textLabel.text]];
    }
}

@end
