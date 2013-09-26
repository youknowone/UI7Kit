//
//  UICPickerViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 15..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICPickerViewController.h"

#import "UI7PickerView.h"

@interface UICPickerViewController ()

@end

@implementation UICPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [(UI7PickerLikeView *)self.pickerView setTextColor:[UIColor redColor]];
//    [(UI7PickerLikeView *)self.pickerView setSelectionIndicatorColor:[UIColor greenColor]];
}

- (void)toggleShowIndicator:(id)sender {
    assert(self.pickerView);
    self.pickerView.showsSelectionIndicator = !self.pickerView.showsSelectionIndicator;
}

- (void)selectToday:(id)sender {
    NSDate *date = [NSDate date];
    [self.pickerView selectRow:date.components.year - 2000 inComponent:0 animated:YES];
    [self.pickerView selectRow:date.components.month inComponent:1 animated:YES];
    [self.pickerView selectRow:date.components.day inComponent:2 animated:YES];
}

#pragma mark 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 20;
        case 1:
            return 12;
        case 2:
            return 30;
        case 3:
            return 2;
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    switch (component) {
        case 0: {
            title = [@"%d" format0:nil, 2000 + row];
        }   break;
        case 1: case 2: {
            title = [@"%d" format0:nil, 1 + row];
        }   break;
        case 3: {
            title = nil;
        }   break;
        default:
            break;
    }
    return title;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (component != 3) {
        return nil;
    }
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UI7SliderThumb"]];
}

@end
