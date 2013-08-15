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


@interface UINavigationItem (Accessor)

@property(nonatomic,assign) UINavigationBar *navigationBar;
@property(nonatomic,readonly) UIColor *tintColor;

@end


@implementation UINavigationItem (Accessor)

NSAPropertyGetter(navigationBar, @"_navigationBar");
NSAPropertyAssignSetter(setNavigationBar, @"_navigationBar");

- (UIColor *)tintColor {
    return self.navigationBar.tintColor;
}

@end


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
- (UIColor *)__tintColor { assert(NO); return nil; }
- (void)__setTintColor:(UIColor *)tintColor { assert(NO); }

- (void)_navigationBarInit {
    [self setBarStyle:self.barStyle];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, 2.0, 1.0, 1.0));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsLandscapePhone];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    for (UINavigationItem *item in self.items) {
        [item _tintColorUpdated];
    }
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
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
        [target copyToSelector:@selector(__setTintColor:) fromSelector:@selector(setTintColor:)];
    }
}

+ (void)patch {
    Class target =  [UINavigationBar class];

    [self exportSelector:@selector(init) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(setBarStyle:) toClass:target];
    [self exportSelector:@selector(pushNavigationItem:) toClass:target];
    if (![UIDevice currentDevice].iOS7) {
        [self exportSelector:@selector(tintColor) toClass:target];
        [self exportSelector:@selector(setTintColor:) toClass:target];
    }
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
        NSDictionary *dict = @{
                               UITextAttributeFont: [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeMedium],
                               UITextAttributeTextShadowColor: [UIColor clearColor],
                               UITextAttributeTextColor: titleColor,
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
        self.titleTextAttributes = dict;
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
        UIBarButtonItem *barButtonItem = [[UI7BarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:nil action:nil];  // this may cause problem if some code depends on existance of this value.
        barButtonItem.appearanceSuperview = self.backItem;
        [barButtonItem _tintColorUpdated];
        self.backItem.backBarButtonItem = barButtonItem;
    }
//    item.navigationBar = self;
    [item _tintColorUpdated];
}
//
//- (id)currentBackButton {
//    id button = [super currentBackButton];
//    dlog(DEBUG_NAVIGATIONBAR, @"ccurrentBackButton: %@ %@", button, [button title]);
//    return button;
//}

- (UIColor *)tintColor {
    UIColor *color = [self __tintColor];
    if (color == nil) {
        color = [self _tintColor];
    }
    return color;
}

- (void)setTintColor:(UIColor *)tintColor {
    [self __setTintColor:tintColor];
    [self _tintColorUpdated];
}

@end




@implementation UINavigationItem (UI7NavigationItem)

- (void)_tintColorUpdated {
    UIBarButtonItem *item = nil;
    item = self.leftBarButtonItem;
    if (item) {
        item.appearanceSuperview = self;
        [item _tintColorUpdated];
    }
    item = self.rightBarButtonItem;
    if (item) {
        item.appearanceSuperview = self;
        [item _tintColorUpdated];
    }
    item = self.backBarButtonItem;
    if (item) {
        item.appearanceSuperview = self;
        [item _tintColorUpdated];
    }
}

@end


@implementation UINavigationItem (Patch)

- (id)__init { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithTitle:(NSString *)title { assert(NO); return nil; }
- (void)__setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem { assert(NO); }
- (void)__setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem { assert(NO); }
- (void)__setBackBarButtonItem:(UIBarButtonItem *)backBarButtonItem { assert(NO); }

@end

@implementation UI7NavigationItem

+ (void)initialize {
    if (self == [UI7NavigationItem class]) {
        Class target = [UINavigationItem class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithTitle:) fromSelector:@selector(initWithTitle:)];
        [target copyToSelector:@selector(__setLeftBarButtonItem:) fromSelector:@selector(setLeftBarButtonItem:)];
        [target copyToSelector:@selector(__setRightBarButtonItem:) fromSelector:@selector(setRightBarButtonItem:)];
        [target copyToSelector:@selector(__setBackBarButtonItem:) fromSelector:@selector(setBackBarButtonItem:)];
    }
}

+ (void)patch {
    Class target = [UINavigationItem class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithTitle:) toClass:target];
    [self exportSelector:@selector(setLeftBarButtonItem:) toClass:target];
    [self exportSelector:@selector(setRightBarButtonItem:) toClass:target];
    [self exportSelector:@selector(setBackBarButtonItem:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    self = [self __initWithTitle:title];
    if (self != nil) {
        
    }
    return self;
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self __setLeftBarButtonItem:barButtonItem];
    barButtonItem.appearanceSuperview = self;
    [barButtonItem _tintColorUpdated];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self __setRightBarButtonItem:barButtonItem];
    barButtonItem.appearanceSuperview = self;
    [barButtonItem _tintColorUpdated];
}

- (void)setBackBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self __setBackBarButtonItem:barButtonItem];
    barButtonItem.appearanceSuperview = self;
    [barButtonItem _tintColorUpdated];
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
