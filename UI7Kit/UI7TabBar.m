//
//  UI7TabBar.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7View.h"
#import "UI7Font.h"
#import "UI7Color.h"

#import "UI7TabBar.h"


NSString *UI7TabBarStyle = @"UI7TabBarStyle";

@interface UITabBar (Private)

- (void)_setLabelFont:(UIFont *)font __deprecated; // rejected
- (void)_setLabelShadowColor:(UIColor *)color __deprecated; // rejected
- (void)_setLabelShadowOffset:(CGSize)size __deprecated; // rejected
- (void)_setLabelTextColor:(UIColor *)textColor selectedTextColor:(UIColor *)selectedTextColor __deprecated; // rejected

@end


@implementation UITabBar (UI7Kit)

- (UIBarStyle)_barStyle {
    NSNumber *styleNumber = [self associatedObjectForKey:UI7TabBarStyle];
    return styleNumber.integerValue;
}

- (void)_setBarStyle:(UIBarStyle)barStyle {
    [self setAssociatedObject:@(barStyle) forKey:UI7TabBarStyle];

    switch (barStyle) {
        case UIBarStyleDefault: {
            self.backgroundColor = [UI7Color defaultBarColor];
        }   break;
        case UIBarStyleBlackOpaque: {
            self.backgroundColor = [UI7Color blackBarColor];
        }   break;
        default:
            break;
    }
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    self.selectedImageTintColor = self.superview.tintColor;
}

@end


@implementation UITabBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_tabBarInit {
    [self _setBarStyle:self.barStyle];

    self.tintColor = [UIColor grayColor];
    self.selectedImageTintColor = self.superview.tintColor;

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, .0, 1.0, 1.0));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundImage = backgroundImage; // Makes tab bar flat
    self.selectionIndicatorImage = [UIImage clearImage]; // Removes selection image
    if ([self respondsToSelector:@selector(setShadowImage:)]) {
        self.shadowImage = [UIImage clearImage];
    }
    // Removed to pass Appstore review
    NSString *name; SEL selector; IMP impl;
    name = [@"_set" stringByAppendingString:@"LabelFont:"];
    selector = NSSelectorFromString(name);
    impl = class_getMethodImplementation(self.class, selector);
    impl(self, selector, [UI7Font systemFontOfSize:10.0 attribute:UI7FontAttributeLight]);
    name = [@"_set" stringByAppendingString:@"LabelShadowOffset:"];
    selector = NSSelectorFromString(name);
    impl = class_getMethodImplementation(self.class, selector);
    impl(self, selector, CGSizeZero);
    name = [@"_set" stringByAppendingString:@"LabelTextColor:selectedTextColor:"];
    selector = NSSelectorFromString(name);
    impl = class_getMethodImplementation(self.class, selector);
    impl(self, selector, [UIColor grayColor], self.tintColor);
}

@end


@implementation UI7TabBar

+ (void)initialize {
    if (self == [UI7TabBar class]) {
        Class target = [UITabBar class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UITabBar class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];

    [target addMethodForSelector:@selector(barStyle) fromMethod:[target methodForSelector:@selector(_barStyle)]];
    [target addMethodForSelector:@selector(setBarStyle:) fromMethod:[target methodForSelector:@selector(_setBarStyle:)]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _tabBarInit];
        [self setTintColor:self.tintColor]; // tweak to regenerate icons
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _tabBarInit];
    }
    return self;
}

@end

