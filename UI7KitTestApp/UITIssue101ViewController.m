//
//  UITIssue101ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 6..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITIssue101ViewController.h"

@interface UITIssue101ViewController ()

@end

@implementation UITIssue101ViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    UIActionSheet *composeActionSheet;
    composeActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"New Photo",@"Existing Photo",@"Location",@"Add Smiley", nil];
    composeActionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    [composeActionSheet setAlpha:0.95f];
    composeActionSheet.tag = 10;
    [composeActionSheet showFromRect:CGRectZero inView:self.tabBarController.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
