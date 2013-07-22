//
//  UI7NavigationBar.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <cdebug/debug.h>
#import "UI7KitPrivate.h"
#import "UI7Font.h"
#import "UI7Color.h"
#import "UI7BarButtonItem.h"

#import "UI7NavigationBar.h"

#define DEBUG_NAVIGATIONBAR NO


@interface UINavigationBar (Private)

- (void)pushNavigationItem:(UINavigationItem *)item;
- (id)currentBackButton; // return UINavigationItemButtonView

@end


@implementation UINavigationBar (Patch)

- (id)init { return [super init]; }
- (id)__init { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__setBarStyle:(UIBarStyle)barStyle { assert(NO); }
- (void)__pushNavigationItem:(UINavigationItem *)item { assert(NO); }

- (void)_navigationBarInit {
    [self setBarStyle:self.barStyle];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, 2.0, 1.0, 1.0));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsLandscapePhone];
}

@end


@implementation UI7NavigationBar

+ (void)initialize {
    if (self == [UI7NavigationBar class]) {
        Class target = [UINavigationBar class];

        [target copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__setBarStyle:) fromSelector:@selector(setBarStyle:)];
        [target copyToSelector:@selector(__pushNavigationItem:) fromSelector:@selector(pushNavigationItem:)];
    }
}

+ (void)patch {
    Class target =  [UINavigationBar class];

    [self exportSelector:@selector(init) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(setBarStyle:) toClass:target];
    [self exportSelector:@selector(pushNavigationItem:) toClass:target];
}

- (id)init {
    self = [self __init];
    if (self) {
        [self _navigationBarInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _navigationBarInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self) {
        [self _navigationBarInit];
    }
    return self;
}

- (void)setBarStyle:(UIBarStyle)barStyle {
    [self __setBarStyle:barStyle];

    UIColor *backgroundColor = nil;
    UIColor *titleColor = nil;
    switch (barStyle) {
        case UIBarStyleDefault: {
            backgroundColor = [UI7Color defaultBarColor];
            titleColor = [UIColor blackColor];
        }   break;
        case UIBarStyleBlackOpaque:
        case UIBarStyleBlackTranslucent: {
            backgroundColor = [UI7Color blackBarColor];
            titleColor = [UIColor whiteColor];
        }   break;
        default:
            break;
    }
    if (titleColor) {
        [self setTitleTextAttributes:@{
                                       UITextAttributeFont: [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeMedium],
                                       UITextAttributeTextShadowColor: [UIColor clearColor],
                                       UITextAttributeTextColor: titleColor,
                                       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                       }];
        // Trick to force rerender title
        NSString *title = [self.topItem.title retain];
        self.topItem.title = @"";
        self.topItem.title = title;
        [title release];
    }
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
}

//- (void)setItems:(NSArray *)items animated:(BOOL)animated {
//    [super setItems:items animated:animated];
//}
//
- (void)pushNavigationItem:(UINavigationItem *)item {
    [self __pushNavigationItem:item];
    dlog(DEBUG_NAVIGATIONBAR, @"pushNavigationItem: %@", self.backItem.backBarButtonItem);
    if (self.backItem.backBarButtonItem == nil) {
        self.backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:nil action:nil];  // this may cause problem if some code depends on existance of this value.
    }
}
//
//- (id)currentBackButton {
//    id button = [super currentBackButton];
//    dlog(DEBUG_NAVIGATIONBAR, @"ccurrentBackButton: %@ %@", button, [button title]);
//    return button;
//}

@end


@interface UI7NavigationItem (Patch)

@end


@implementation UI7NavigationItem

- (void)_navigationItemInit {
//    self.backBarButtonItem
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title];
    if (self != nil) {
        
    }
    return self;
}

//- (UIBarButtonItem *)backBarButtonItem {
//    UIBarButtonItem *item = [super backBarButtonItem];
//    return item;
//}
//
//- (void)setBackBarButtonItem:(UIBarButtonItem *)backBarButtonItem {
//    [super setBackBarButtonItem:backBarButtonItem];
//}

@end
