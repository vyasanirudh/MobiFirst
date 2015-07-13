//
//  FilterSelectionViewController.h
//  MobiFirst Video Filter POC
//
//  Created by Anirudh Vyas on 12/07/15.
//  Copyright (c) 2015 Anirudh Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Custom Protocol

@protocol FilterSelectionDelegate <NSObject>

- (void) filterSelectionTableTappedOnCellWithTitle:(NSString*)filterOrSettingSelectedString andFilterType:(kSelectionType)filterType;

@end

@interface FilterSelectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView* filterSelectionOptionTableView;

/*Preping the setters and getters for the custom protocol defined for the class.*/
@property (nonatomic, strong) id <FilterSelectionDelegate> filterSelectionDelegate;

@end
