//
//  UICSliderProgressViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 4..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UICSliderProgressViewController.h"

@implementation UICSliderProgressView

- (void)changed:(id)sender {
    self.progressView.progress = self.slider.value;
}

@end

@interface UICSliderProgressViewController ()

@end

@implementation UICSliderProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.codeView.slider.maximumTrackTintColor = self.codeView.progressView.trackTintColor = [UIColor colorWithRed:1.0 green:.0 blue:0.5 alpha:1.0];
    self.codeView.slider.minimumTrackTintColor = self.codeView.progressView.progressTintColor = [UIColor colorWithRed:0.5 green:.0 blue:1.0 alpha:1.0];
}

@end
