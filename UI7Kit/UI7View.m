//
//  UI7View.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7View.h"

NSString *UI7AppearanceSuperview = @"UI7AppearanceSuperview";
static NSString *UI7ViewTintColor = @"UI7ViewTintColor";

@implementation UIView (Patch)

- (void)__view_setBackgroundColor:(UIColor *)backgroundColor { assert(NO); }
- (void)_tintColorDidChange { }

@end


@implementation UIView (UI7View)

+ (void)initialize {
    if (self == [UIView class]) {
        if ([UIDevice currentDevice].needsUI7Kit) {
            [self addMethodForSelector:@selector(tintColor) fromMethod:[self methodForSelector:@selector(_view_tintColor)]];
            [self addMethodForSelector:@selector(setTintColor:) fromMethod:[self methodForSelector:@selector(_view_setTintColor:)]];
            [self addMethodForSelector:@selector(tintColorDidChange) fromMethod:[self methodForSelector:@selector(_tintColorDidChange)]];
        }
    }
}

- (UIColor *)_view_tintColor {
    UIColor *color = [self associatedObjectForKey:UI7ViewTintColor];
    if (color) {
        return color;
    }
    if (self.superview) {
        return self.superview.tintColor;
    }
    return self.window.tintColor;
}

- (void)_view_setTintColor:(UIColor *)color {
    [self setAssociatedObject:color forKey:UI7ViewTintColor];
    [self _tintColorUpdated];
}

- (UIColor *)__tintColor { assert(NO); return nil; }

- (UIColor *)_tintColor {
    UIColor *tintColor = [self _view_tintColor];
    if (tintColor == nil) {
        tintColor = self.superview.tintColor;
        if (tintColor == nil) {
            tintColor = self.window.tintColor;
        }
    }
    return tintColor;
}

- (void)_tintColorUpdated {
    if (self.tintColor == nil) return;

    [self tintColorDidChange];
    for (UIView *subview in self.subviews) {
        if ([subview respondsToSelector:@selector(_tintColorUpdated)]) {
            [subview _tintColorUpdated];
        }
    }
}

- (void)_backgroundColorUpdated {
    if (self.backgroundColor == nil) return;

    for (UIView *subview in self.subviews) {
        if (subview.backgroundColor.components.alpha < 1.0f && [subview respondsToSelector:@selector(_backgroundColorUpdated)]) {
            [subview _backgroundColorUpdated];
        }
    }
}

- (UIColor *)stackedBackroundColor {
    CGFloat red = .0, green = .0, blue = .0, alpha = .0;
    UIView *view = self;
    while (view && alpha < 1.0f) {
        if (view.backgroundColor) {
            UIAColorComponents *components = view.backgroundColor.components;
            if (components.alpha > .0f) {
                red = red * alpha + components.red * components.alpha;
                green = green * alpha + components.green * components.alpha;
                blue = blue * alpha + components.blue * components.alpha;
                alpha += (1.0f - alpha) * components.alpha;
                if (components.alpha == 1.0f) break;
            }
        }
        view = view.superview;
    }
    if (alpha == .0) {
        return [UIColor whiteColor];
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void)_didMoveToSuperview {
    if (self.tintColor) {
        [self _tintColorUpdated];
    }
    [self _backgroundColorUpdated];
}

- (void)_didMoveToWindow {
    if (self.tintColor) {
        [self _tintColorUpdated];
    }
    [self _backgroundColorUpdated];
}

@end


@implementation UI7View

+ (void)initialize {
    if (self == [UI7View class]) {
        Class target = [UIView class];

        [target copyToSelector:@selector(__view_setBackgroundColor:) fromSelector:@selector(setBackgroundColor:)];
    }
}

+ (void)patch {
    Class target = [UIView class];

    [self exportSelector:@selector(setBackgroundColor:) toClass:target];
    [self copyToSelector:@selector(didMoveToSuperview) fromSelector:@selector(_didMoveToSuperview)];
    [self copyToSelector:@selector(didMoveToWindow) fromSelector:@selector(_didMoveToWindow)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self __view_setBackgroundColor:backgroundColor];
    [self _backgroundColorUpdated];
}

@end

