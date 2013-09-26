//
//  UICPickerViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 15..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICPickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic,retain) IBOutlet UIPickerView *pickerView;
- (IBAction)toggleShowIndicator:(id)sender;
- (IBAction)selectToday:(id)sender;

@end
