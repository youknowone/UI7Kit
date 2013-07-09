//
//  UICGlobalSettingsViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 10..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICGlobalSettingsViewController : UITableViewController

@property(nonatomic,strong) IBOutlet UISwitch *patchSwitch;
@property(nonatomic,strong) IBOutlet UISegmentedControl *barStyleSegmentedControl;

- (IBAction)patchChanged:(id)sender;
- (IBAction)barStyleChanged:(id)sender;

@end
