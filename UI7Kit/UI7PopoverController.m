//
//  UI7PopoverController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 6..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UI7Kit/UI7Utilities.h>

#import "UI7PopoverController.h"

@implementation UIPopoverController (Patch)

- (id)__initWithContentViewController:(UIViewController *)viewController { assert(NO); return nil; }

@end


@implementation UI7PopoverController

+ (void)initialize {
    if (self == [UI7PopoverController class]) {
        Class target = [UIPopoverController class];

        [target copyToSelector:@selector(__initWithContentViewController:) fromSelector:@selector(initWithContentViewController:)];
    }
}

+ (void)patch {
    Class target = [UIPopoverController class];

    [self exportSelector:@selector(initWithContentViewController:) toClass:target];
}

- (id)initWithContentViewController:(UIViewController *)viewController {
    self = [self __initWithContentViewController:viewController];
    if (self != nil) {
        [self setPopoverBackgroundViewClass:[UI7PopoverBackgroundView class]];
    }
    return self;
}

@end


@interface UI7PopoverBackgroundView (Private)

@property (strong, nonatomic) UIImageView *popoverBackground;

@end


@implementation UI7PopoverBackgroundView

- (void)layoutSubviews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0f;
    [super layoutSubviews];
    //self.popoverBackground.image = [self.popoverBackground.image imageByFilledWithColor:[UIColor whiteColor]];
    self.layer.shadowRadius = 500.0f; // immitate dimming view
}

@end
