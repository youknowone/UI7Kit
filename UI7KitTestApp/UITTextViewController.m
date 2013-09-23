//
//  UITTextViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 4. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITTextViewController.h"

@interface UITTextViewController ()

@end

@implementation UITTextViewController

NSString *UITTextViewControllerLoremIpsum = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeholderString = @"This is long long place holder may work ";
    // Do any additional setup after loading the view from its nib.
    self.textView.placeholderTextView.textAlignment = NSTextAlignmentCenter;
    
    UIFont *newFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textView.font = newFont;
}

- (void)switched:(UISwitch *)sender {
    if (sender.on) {
        self.textView.text = UITTextViewControllerLoremIpsum;
    } else {
        self.textView.text = @"";
    }
}

- (void)resign:(id)sender {
    [self.textView resignFirstResponder];
    [self.textView endEditing:YES];
}

@end
