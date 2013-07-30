//
//  UITBarItemViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 31..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITBarItemViewController.h"

@interface UITBarItemViewController ()

@end

@implementation UITBarItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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

- (void)addTabBar:(id)sender {
    UITabBarSystemItem systemItem = arc4random() % (UITabBarSystemItemMostViewed + 1);
    UITabBarItem *item = [[[UITabBarItem alloc] initWithTabBarSystemItem:systemItem tag:0] autorelease];
    self.tabBar.items = [self.tabBar.items arrayByAddingObject:item];
}

@end
