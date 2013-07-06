//
//  UITSegmentedControlViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 4..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITSegmentedControlViewController.h"

@interface UITSegmentedControlViewController ()

@end

@implementation UITSegmentedControlViewController

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

    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc] initWithItems:@[@"Item1", @"Item2", @"Item3"]] autorelease];
    segmentedControl.frame = CGRectMake(20.0, 10.0, 280, segmentedControl.frame.size.height);
    [self.view addSubview:segmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorChanged:(id)sender {
    [super colorChanged:sender];
    self.segmented1.tintColor = self.view.tintColor;
    self.segmented2.tintColor = self.view.tintColor;
}

@end
