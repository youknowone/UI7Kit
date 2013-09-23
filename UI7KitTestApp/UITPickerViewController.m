//
//  UITPickerViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 5..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITPickerViewController.h"

@interface UITPickerViewController ()

@end

@implementation UITPickerViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 20;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger selectedRow = [pickerView selectedRowInComponent:component];
    assert(selectedRow == row);
    NSLog(@"select %d %d", component, row);
}

- (void)backgroundColorChanged:(UISlider *)sender {
    self.view.backgroundColor = [UIColor colorWithRed:sender.value green:sender.value * sender.value blue:1.0 - pow(1 - sender.value, 2) alpha:1.0];
}

@end
