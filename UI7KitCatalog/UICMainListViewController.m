//
//  UICMainListViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 10..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICUserDefaults.h"
#import "UICMainListViewController.h"

@interface UICMainListViewController ()

@end

@implementation UICMainListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarStyle style = UICUserDefaults.globalBarStyle;

    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyle)style];
    self.navigationController.navigationBar.barStyle = style;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
