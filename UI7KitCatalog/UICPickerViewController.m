//
//  UICPickerViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 15..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICPickerViewController.h"

@interface UICPickerViewController ()

@end

@implementation UICPickerViewController

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 20;
        case 1:
            return 12;
        case 2:
            return 30;
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
        case 1: {
            title = [@"%d" format0:nil, 1 + row];
        }
        case 2: {
            title = [@"%d" format0:nil, 1 + row];
        }
        default:
            break;
    }
    return title;
}

@end
