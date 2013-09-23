//
//  UITIssue12ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 6..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITIssue12ViewController.h"

@interface UITIssue12ViewController ()

@end

@implementation UITIssue12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISegmentedControl *segmented1 = [[UISegmentedControl alloc] initWithItems:@[@"First", @"Second", @"Thired"]];
    segmented1.frame = CGRectMake(20.0, 60.0, 280.0, segmented1.frame.size.height);
    [self.view addSubview:segmented1];

    UISegmentedControl *segmented2 = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20.0, 100.0, 280.0, UI7SegmentedControlHeight)];
    [segmented2 insertSegmentWithTitle:@"Third" atIndex:0 animated:NO];
    [segmented2 insertSegmentWithTitle:@"Second" atIndex:0 animated:NO];
    [segmented2 insertSegmentWithTitle:@"First" atIndex:0 animated:NO];
    [self.view addSubview:segmented2];

    for (UISegmentedControl *segmentedControl in @[self.segmentedControl, segmented1, segmented2]) {
        NSDictionary * selectedAttributesDictionary = @{UITextAttributeTextColor: [UIColor whiteColor]};

        NSDictionary * deselectedAttributesDictionary = @{UITextAttributeTextColor: [UIColor redColor]};

        [segmentedControl setTitleTextAttributes:deselectedAttributesDictionary forState:UIControlStateNormal];
        [segmentedControl setTitleTextAttributes:selectedAttributesDictionary forState:UIControlStateSelected];

        segmentedControl.tintColor = [UIColor colorWith32bitColor:arc4random()];
    }
}

@end
