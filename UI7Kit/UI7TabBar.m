//
//  UI7TabBar.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7TabBar.h"

@interface UITabBar (Private)

- (void)_setLabelFont:(UIFont *)font;
- (void)_setLabelShadowColor:(UIColor *)color;
- (void)_setLabelShadowOffset:(CGSize)size;
- (void)_setLabelTextColor:(UIColor *)textColor selectedTextColor:(UIColor *)selectedTextColor;

@end


@implementation UITabBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_tabBarInit {
    self.tintColor = [UIColor grayColor];
    self.selectedImageTintColor = [UI7Kit kit].tintColor;
    self.backgroundColor = [UIColor iOS7BackgroundColor];
    self.backgroundImage = [UIImage imageNamed:@"UI7TabBarBackground"]; // Makes tab bar flat
    self.selectionIndicatorImage = [UIImage blankImage]; // Removes selection image
    if ([self respondsToSelector:@selector(setShadowImage:)]) {
        self.shadowImage = [UIImage blankImage];
    }
    // private properties
    [self _setLabelFont:[UIFont iOS7SystemFontOfSize:10.0 weight:@"Light"]];
    [self _setLabelShadowOffset:CGSizeZero];
    [self _setLabelTextColor:[UIColor grayColor] selectedTextColor:[UI7Kit kit].tintColor];
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

