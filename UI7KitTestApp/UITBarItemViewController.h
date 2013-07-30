//
//  UITBarItemViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 31..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITTintViewController.h"

@interface UITBarItemViewController : UITTintViewController

@property(nonatomic,strong) IBOutlet UITabBar *tabBar;

- (IBAction)addTabBar:(id)sender;

@end
