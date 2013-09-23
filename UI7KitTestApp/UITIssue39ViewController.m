//
//  UITIssue39ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 29..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITIssue39ViewController.h"

@interface UITIssue39ViewController ()

@end

@implementation UITIssue39ViewController

- (void)showAlert:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Issue #39" message:@"Continuous alert view call test." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Keep going", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) return;

    [self showAlert:alertView];
}

@end
