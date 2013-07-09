//
//  UICGlobalSettingsViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 10..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICUserDefaults.h"

#import "UICGlobalSettingsViewController.h"

@interface UICGlobalSettingsViewController ()

@end

@implementation UICGlobalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.patchSwitch.on = UICUserDefaults.globalPatch;
    self.barStyleSegmentedControl.selectedSegmentIndex = UICUserDefaults.globalBarStyle;
}

#pragma mark - events

- (void)patchChanged:(UISwitch *)sender {
    UICUserDefaults.globalPatch = sender.on;

    [UIAlertView showNoticeWithTitle:@"Restart required" message:@"This setting is adjusted after restarting." cancelButtonTitle:@"OK"];
}

- (void)barStyleChanged:(UISegmentedControl *)sender {
    UIBarStyle style = UICUserDefaults.globalBarStyle = sender.selectedSegmentIndex;

    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyle)style];
    self.navigationController.navigationBar.barStyle = style;
}

@end
