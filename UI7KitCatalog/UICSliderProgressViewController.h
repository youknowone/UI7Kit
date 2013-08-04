//
//  UICSliderProgressViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 4..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICSliderProgressView : UIView

@property(nonatomic,strong) IBOutlet UISlider *slider;
@property(nonatomic,strong) IBOutlet UIProgressView *progressView;

- (IBAction)changed:(id)sender;

@end


@interface UICSliderProgressViewController : UIViewController

@property(nonatomic,strong) IBOutlet UICSliderProgressView *codeView;

@end
