//
//  UITAlertViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 30..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#if BLOCKSKIT
    #import <BlocksKit/BlocksKit.h>
#endif
#import "UITAlertViewController.h"

@interface UITAlertViewController ()

@end

@implementation UITAlertViewController

- (void)defaultButton1:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

- (void)defaultButton2:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)blockskitButton2:(id)sender {
    #if BLOCKSKIT
    UIAlertView *alertView = [UIAlertView alertViewWithTitle:@"Activate Your Account" message:@"You need to activate your account."];
    [alertView addButtonWithTitle:@"Activate" handler:^{

    }];
    [alertView setCancelButtonWithTitle:@"Later" handler:nil];
    [alertView show];
    #endif
}

- (void)defaultButton3:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK1", @"OK2", nil];
    [alert show];
}

- (void)inputButton1:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)inputButton2:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)inputButton3:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK1", @"OK2", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)inputField2:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}

@end
