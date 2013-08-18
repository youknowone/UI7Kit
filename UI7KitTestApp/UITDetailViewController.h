//
//  UITDetailViewController.h
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import "UITTintViewController.h"

@interface UITDetailViewController : UITTintViewController

@property(nonatomic,strong) IBOutlet UIToolbar *toolbar;

- (IBAction)showAlertView1:(id)sender;
- (IBAction)showAlertView2:(id)sender;
- (IBAction)showAlertView3:(id)sender;
- (IBAction)showActionSheet1:(id)sender;
- (IBAction)showActionSheet2:(id)sender;
- (IBAction)showActionSheet3:(id)sender;
- (IBAction)showActionSheet4:(id)sender;

- (IBAction)changeStepperColor:(id)sender;

@end
