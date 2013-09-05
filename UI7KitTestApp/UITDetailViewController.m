//
//  UITDetailViewController.m
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import "UITDetailViewController.h"

@interface UITDetailViewController ()

@end


@implementation UITDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.toolbar.barStyle = self.navigationController.navigationBar.barStyle;
}

- (void)showAlertView1:(id)sender {
    NSString *title = @"Title";
    NSString *message = @"Message";
    [UIAlertView showNoticeWithTitle:title message:message cancelButtonTitle:@"OK"];
}

- (void)showAlertView2:(id)sender {
    NSString *title = @"Is this test string can be as long as long cat? Or should I test long long longer cat? Like, caaaaaaaaaaaaaaaaaaaaaaaaaaat? I doubt even there is limitation of lines of title or not. Say, is this become long as much as burst to top and bottom of screen? And how much sentence should I write down to reach the end of the screen? I am not a good author. I feel tired to write this sentences.";
    NSString *message = @"Is this test string can be as long as long cat? I don't know how much it long, but it should be long enough to finish my test.";
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [view show];
    [view release];
}

- (void)showAlertView3:(id)sender {
    NSString *title = @"Common title";
    NSString *message = @"Uncommon buttons";
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Button1", @"Button2", @"Button3", @"Button4", @"Button5", nil];
    [view show];
    [view release];
}

- (void)showActionSheet1:(UISwitch *)sender {
    NSString *title = @"Title";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"Other", @"Buttons", nil];
    actionSheet.actionSheetStyle = (UIActionSheetStyle)self.navigationController.navigationBar.barStyle;
    if (self.tabBarController) {
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    } else {
        [actionSheet showInView:self.view];
    }
}

- (void)showActionSheet2:(UISwitch *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"Other", @"Buttons", nil];
    actionSheet.actionSheetStyle = (UIActionSheetStyle)self.navigationController.navigationBar.barStyle;
    if (self.tabBarController) {
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    } else {
        [actionSheet showInView:self.view];
    }
}

- (void)showActionSheet3:(UISwitch *)sender {
    NSString *title = @"Title";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"Other", @"Buttons", @"Is", @"Many", @"At", @"This", @"Time", nil];
    actionSheet.actionSheetStyle = (UIActionSheetStyle)self.navigationController.navigationBar.barStyle;
    if (self.tabBarController) {
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    } else {
        [actionSheet showInView:self.view];
    }
}

- (void)showActionSheet4:(UISwitch *)sender {
    NSString *title = @"Title is long long longer at this time. How long? This long.";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"Other", @"Buttons", @"Is", @"Many", @"At", @"This", @"Time", nil];
    actionSheet.actionSheetStyle = (UIActionSheetStyle)self.navigationController.navigationBar.barStyle;

    if (self.tabBarController) {
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    } else {
        [actionSheet showInView:self.view];
    }
}

- (void)changeStepperColor:(UIStepper *)sender {
    sender.tintColor = [UIColor colorWith8bitRed:60 + sender.value green:120 + sender.value blue:180 + sender.value alpha:255];
}

@end
