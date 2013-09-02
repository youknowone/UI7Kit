//
//  UITTextViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 4. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

@interface UITTextViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIAPlaceholderTextView *textView;

- (IBAction)switched:(id)sender;
- (IBAction)resign:(id)sender;

@end
