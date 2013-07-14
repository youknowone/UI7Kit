//
//  UITIssue41ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 13..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "UITIssue41ViewController.h"

@interface UITIssue41ViewController ()

@end

@implementation UITIssue41ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
    composeViewController.delegate = self;
    [self presentModalViewController:composeViewController animated:YES];
    composeViewController.topViewController.title = @"Send mail";
    [composeViewController setSubject:@"Subject"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end
