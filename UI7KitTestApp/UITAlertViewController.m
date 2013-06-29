//
//  UITAlertViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 30..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITAlertViewController.h"

@interface UITAlertViewController ()

@end

@implementation UITAlertViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultButton1:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)defaultButton2:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] autorelease];
    [alert show];
}

- (void)defaultButton3:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK1", @"OK2", nil] autorelease];
    [alert show];
}

- (void)inputButton1:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)inputButton2:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] autorelease];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)inputButton3:(id)sender {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK1", @"OK2", nil] autorelease];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

@end
