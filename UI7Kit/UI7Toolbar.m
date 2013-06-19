//
//  UI7Toolbar.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Toolbar.h"

@implementation UIToolbar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_toolbarInit {
    self.backgroundColor = [UIColor iOS7BackgroundColor];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, .0, 1.0, 1.0));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    context = UIGraphicsGetCurrentContext();
    [[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, .0, 1.0, 1.0));
    backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forToolbarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:backgroundImage forToolbarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}

@end


@implementation UI7Toolbar

+ (void)initialize {
    if (self == [UI7Toolbar class]) {
        Class origin = [UIToolbar class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];

    }
}

+ (void)patch {
    Class origin = [self class];
    Class target = [UIToolbar class];

    [origin exportSelector:@selector(initWithFrame:) toClass:target];
    [origin exportSelector:@selector(initWithCoder:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _toolbarInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _toolbarInit];
    }
    return self;
}

@end
