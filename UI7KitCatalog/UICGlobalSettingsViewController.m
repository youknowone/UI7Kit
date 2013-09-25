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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    UIImage *image = self.tintColorCell.imageView.image;
    if (image == nil) {
        image = [UIImage imageNamed:@"UITabBarFavoritesTemplateSelected"];
    }
    self.tintColorCell.imageView.image = [image imageByFilledWithColor:self.view.tintColor];
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


@implementation UICTintColorSettingsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIColor *color = UICUserDefaults.globalTintColor;
    if (color == nil) {
        color = [UI7Kit kit].tintColor;
    }
    UIAColorComponents *components = color.components;
    self.redSlider.value = components.red;
    self.greenSlider.value = components.green;
    self.blueSlider.value = components.blue;
}

- (void)colorChanged:(id)sender {
    UIColor *tintColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:1.0];
    self.view.window.tintColor = tintColor;
    self.view.tintColor = tintColor;
    UICUserDefaults.globalTintColor = tintColor;
}

@end


@implementation UICBackgroundColorSettingsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIColor *color = UICUserDefaults.globalBackgroundColor;
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    UIAColorComponents *components = color.components;
    self.redSlider.value = components.red;
    self.greenSlider.value = components.green;
    self.blueSlider.value = components.blue;

    color = UICUserDefaults.globalTintColor;
    if (color == nil) {
        color = [UI7Kit kit].tintColor;
    }
    self.redSlider.minimumTrackTintColor = color;
    self.greenSlider.minimumTrackTintColor = color;
    self.blueSlider.minimumTrackTintColor = color;
}

- (void)colorChanged:(id)sender {
    UIColor *color = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:1.0];
    self.view.window.backgroundColor = color;
    self.view.backgroundColor = color;
    UICUserDefaults.globalBackgroundColor = color;
}

@end
