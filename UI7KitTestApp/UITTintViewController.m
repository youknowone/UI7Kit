//
//  UITTintViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 30..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITTintViewController.h"

@interface UITTintViewController ()

@end

@implementation UITTintViewController

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

- (void)colorChanged:(UISlider *)sender {
    UIWindow *window = self.view.window;
    UIColor *color = window.tintColor;
    CGFloat red = sender.tag == 0 ? sender.value : color.components.red;
    CGFloat green = sender.tag == 1 ? sender.value : color.components.green;
    CGFloat blue = sender.tag == 2 ? sender.value : color.components.blue;
    window.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
