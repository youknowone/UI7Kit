//
//  UITPickerViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 5..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITTintViewController.h"

@interface UITPickerViewController : UITTintViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong,nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)backgroundColorChanged:(id)sender;

@end
