//
//  UITMasterViewController.h
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//


@class UITDetailViewController;

@interface UITMasterViewController : UIViewController<UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *listTableView;
@property(nonatomic,strong) IBOutlet UISegmentedControl *styleSegmentedControl;

- (IBAction)styleChanged:(id)sender;

@end
