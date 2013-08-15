//
//  UI7Toolbar.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7Color.h"

#import "UI7Toolbar.h"

@implementation UIToolbar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__setBarStyle:(UIBarStyle)barStyle { assert(NO); }

- (void)_toolbarInit {
    [self setBarStyle:self.barStyle];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, .0, 1.0, 1.0));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, .0, 1.0, 1.0));
    backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forToolbarPosition:UIToolbarPositionTop barMetrics:UIBarMetricsDefault];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    for (UIBarButtonItem *item in self.items) {
        item.appearanceSuperview = self.superview;
        [item _tintColorUpdated];
    }
}

@end


@implementation UI7Toolbar

+ (void)initialize {
    if (self == [UI7Toolbar class]) {
        Class target = [UIToolbar class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__setBarStyle:) fromSelector:@selector(setBarStyle:)];
    }
}

+ (void)patch {
    Class target = [UIToolbar class];

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(setBarStyle:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _toolbarInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self) {
        [self _toolbarInit];
    }
    return self;
}

- (void)setBarStyle:(UIBarStyle)barStyle {
    [self __setBarStyle:barStyle];

    switch (barStyle) {
        case UIBarStyleDefault: {
            self.backgroundColor = [UI7Kit kit].backgroundColor;
        }   break;
        case UIBarStyleBlackOpaque: {
            self.backgroundColor = [UIColor colorWith8bitWhite:90 alpha:255];
        }   break;
        default:
            break;
    }
}

@end
