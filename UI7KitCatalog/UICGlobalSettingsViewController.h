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
@property(nonatomic,strong) IBOutlet UITableViewCell *tintColorCell;

- (IBAction)patchChanged:(id)sender;
- (IBAction)barStyleChanged:(id)sender;

@end


@interface UICTintColorSettingsViewController : UIViewController

@property(nonatomic,strong) IBOutlet UISlider *redSlider, *greenSlider, *blueSlider;

- (IBAction)colorChanged:(id)sender;

@end


@interface UICBackgroundColorSettingsViewController : UIViewController

@property(nonatomic,strong) IBOutlet UISlider *redSlider, *greenSlider, *blueSlider;

- (IBAction)colorChanged:(id)sender;

@end
