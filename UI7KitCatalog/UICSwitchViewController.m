//
//  UICSwitchViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 4..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICSwitchViewController.h"

@interface UICSwitchViewController ()

@end

@implementation UICSwitchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.onTintColorSwitch.onTintColor = [UIColor colorWithRed:1.0 green:0.5 blue:.0 alpha:1.0];
    self.thumbTintColorSwitch.thumbTintColor = [UIColor colorWithRed:1.0 green:0.5 blue:.0 alpha:1.0];

//    self.onTintColorSwitch.on = YES;
//    self.thumbTintColorSwitch.on = YES;
//    assert(self.onTintColorSwitch.on == YES);
//    assert(self.thumbTintColorSwitch.on == YES);
}

@end
