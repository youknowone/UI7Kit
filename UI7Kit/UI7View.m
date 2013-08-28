//
//  UI7View.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
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
            if ([UIDevice currentDevice].iOS7) {
                [self copyToSelector:@selector(_current_tintColor) fromSelector:@selector(tintColor)];
                [self copyToSelector:@selector(_current_setTintColor:) fromSelector:@selector(setTintColor:)];
                [self copyToSelector:@selector(tintColor) fromSelector:@selector(_view_tintColor)];
                [self copyToSelector:@selector(setTintColor:) fromSelector:@selector(_view_setTintColor:)];
            } else {
                [self addMethodForSelector:@selector(tintColorDidChange) fromMethod:[self methodObjectForSelector:@selector(_tintColorDidChange)]];
                [self addMethodForSelector:@selector(tintColor) fromMethod:[self methodObjectForSelector:@selector(_view_tintColor)]];
                [self addMethodForSelector:@selector(setTintColor:) fromMethod:[self methodObjectForSelector:@selector(_view_setTintColor:)]];
            }
        }
    }
}

- (UIColor *)_current_tintColor {
    return [self associatedObjectForKey:UI7ViewTintColor];
}

- (void)_current_setTintColor:(UIColor *)color {
    [self setAssociatedObject:color forKey:UI7ViewTintColor];
}

- (UIColor *)_view_tintColor {
    // UIWindow -> UILayoutContainerView -> UITransitionView -> UIViewControllerWrapperView -> UILayoutContainerView -> UINavigationTransitaionView -> UIViewControllerWrapperView -> UIView (UIViewController)
    UIColor *color = [self _current_tintColor];
    if (color == nil) {
        color = self.superview.tintColor;
        if (color == nil) {
            color = self.window.tintColor;
        }
    }
    return color;
}

- (void)_view_setTintColor:(UIColor *)color {
    [self _current_setTintColor:color];
    [self _tintColorUpdated];
}

- (UIColor *)_tintColor {
    UIColor *tintColor = [self _view_tintColor];
    return tintColor;
}

- (void)_setTintColor:(UIColor *)color {
    [self _view_setTintColor:color];
}

- (void)_tintColorUpdated {
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

- (UIColor *)stackedBackgroundColor {
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
    [self _tintColorUpdated];
    [self _backgroundColorUpdated];
}

- (void)_didMoveToWindow {
    [self _tintColorUpdated];
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
    [target copyToSelector:@selector(didMoveToSuperview) fromSelector:@selector(_didMoveToSuperview)];
    [target copyToSelector:@selector(didMoveToWindow) fromSelector:@selector(_didMoveToWindow)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self __view_setBackgroundColor:backgroundColor];
    [self _backgroundColorUpdated];
}

@end

