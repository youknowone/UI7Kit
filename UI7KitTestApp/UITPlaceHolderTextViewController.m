//
//  UITPlaceholderTextViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 4. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITPlaceholderTextViewController.h"

@interface UITPlaceholderTextViewController ()

@end

@implementation UITPlaceholderTextViewController

NSString *UITPlaceholderTextViewControllerLoremIpsum = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";;

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
    self.textView.placeholderString = @"This is long long place holder may work";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switched:(UISwitch *)sender {
    if (sender.on) {
        self.textView.text = UITPlaceholderTextViewControllerLoremIpsum;
    } else {
        self.textView.text = @"";
    }
}

@end
