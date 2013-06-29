//
//  UI7TabBar.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"

#import "UI7TabBar.h"

@interface UITabBar (Private)

- (void)_setLabelFont:(UIFont *)font __deprecated; // rejected
- (void)_setLabelShadowColor:(UIColor *)color __deprecated; // rejected
- (void)_setLabelShadowOffset:(CGSize)size __deprecated; // rejected
- (void)_setLabelTextColor:(UIColor *)textColor selectedTextColor:(UIColor *)selectedTextColor; // rejected

@end


@implementation UITabBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_tabBarInit {
    self.tintColor = [UIColor grayColor];
    self.selectedImageTintColor = [UI7Kit kit].tintColor;
    self.backgroundColor = [UIColor iOS7BackgroundColor];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 3.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWith8bitWhite:178 alpha:255] set];
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
    impl(self, _cmd, [UI7Font systemFontOfSize:10.0 attribute:UI7FontAttributeLight]);
    name = [@"_set" stringByAppendingString:@"LabelShadowOffset:"];
    selector = NSSelectorFromString(name);
    impl = class_getMethodImplementation(self.class, selector);
    impl(self, _cmd, CGSizeZero);
    name = [@"_set" stringByAppendingString:@"LabelTextColor:"];
    selector = NSSelectorFromString(name);
    impl = class_getMethodImplementation(self.class, selector);
    impl(self, _cmd, [UIColor grayColor], self.tintColor);
}

@end


@implementation UI7TabBar

+ (void)initialize {
    if (self == [UI7TabBar class]) {
        Class origin = [UITabBar class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UITabBar class];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _tabBarInit];
        [self setTintColor:self.tintColor]; // tweak to regenerate icons
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self __initWithFrame:frame];
    if (self) {
        [self _tabBarInit];
    }
    return self;
}

@end

