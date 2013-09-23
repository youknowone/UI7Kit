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

- (void)addTabBar:(id)sender {
    UITabBarSystemItem systemItem = arc4random() % (UITabBarSystemItemMostViewed + 1);
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem tag:0];
    self.tabBar.items = [self.tabBar.items arrayByAddingObject:item];
}

@end
