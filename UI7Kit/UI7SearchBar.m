//
//  UI7SearchBar.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 30..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UI7Color.h"
#import "UI7SearchBar.h"

@implementation UISearchBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_searchBarInit {
    CGFloat height = self.frame.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(1.0, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, height - 1.0f, 1.0f, 1.0f));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWith8bitRed:201 green:201 blue:205 alpha:255];
    self.backgroundImage = backgroundImage;
    self.placeholder = @" ";
    
    UIBarButtonItem *searchBarButton = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
    [searchBarButton setBackgroundImage:[UIColor clearColor].image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:16], UITextAttributeTextColor : [UIColor colorWithRed:0.286f green:0.494f blue:0.961f alpha:1.000f], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],} forState:UIControlStateNormal];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor lightGrayColor], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],} forState:UIControlStateHighlighted];

    for (UIView *searchBarSubview in [self subviews]) {
        if ([searchBarSubview respondsToSelector:@selector(setBorderStyle:)]) {
            [(UITextField *)searchBarSubview setBorderStyle:UITextBorderStyleRoundedRect];
            searchBarSubview.layer.borderColor = UIColor.clearColor.CGColor;
        }
    }
}

@end


@implementation UI7SearchBar

+ (void)initialize {
    if (self == [UI7SearchBar class]) {
        Class target = [UISearchBar class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UISearchBar class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _searchBarInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _searchBarInit];
    }
    return self;
}

@end
