//
//  UICRoundedRectButtonViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 3..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICRoundedRectButtonViewController.h"

@interface UICRoundedRectButtonViewController ()

@end

@implementation UICRoundedRectButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithHTMLExpression:@"#af8"];
    self.roundedCodeButton.tintColor = color;
    self.codeButton.tintColor = color;
    self.borderedCodeButton.tintColor = color;
    NSLog(@"button colors: %@ %@ %@", color, self.codeButton.tintColor, self.roundedCodeButton.tintColor);
    assert([self.roundedCodeButton.tintColor isEqual:color]);
    assert([self.codeButton.tintColor isEqual:color]);
    assert([self.borderedCodeButton.tintColor isEqual:color]);
}

@end
