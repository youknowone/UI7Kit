//
//  UI7View.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7View.h"

NSMutableDictionary *UI7TintColors = nil;

@implementation UIView (UI7View)

+ (void)initialize {
    if (self == [UIView class]) {
        if ([UIDevice currentDevice].needsUI7Kit) {
            UI7TintColors = [[NSMutableDictionary alloc] init];
            [self addMethodForSelector:@selector(tintColor) fromMethod:[self methodForSelector:@selector(_view_tintColor)]];
            [self addMethodForSelector:@selector(setTintColor:) fromMethod:[self methodForSelector:@selector(_view_setTintColor:)]];
            [self copyToSelector:@selector(__view_dealloc) fromSelector:@selector(dealloc)];
            [self copyToSelector:@selector(dealloc) fromSelector:@selector(_view_dealloc)];
        }
    }
}

- (UIColor *)_view_tintColor {
    if ([UI7TintColors containsKey:self.pointerString]) {
        return UI7TintColors[self.pointerString];
    }
    if (self.superview) {
        return self.superview.tintColor;
    }
    return [[UI7Kit kit] tintColor];
}

- (void)_view_setTintColor:(UIColor *)color {
    if (color) {
        UI7TintColors[self.pointerString] = color;
    } else {
        if ([UI7TintColors containsKey:self.pointerString]) {
            [UI7TintColors removeObjectForKey:self.pointerString];
        }
    }
}

- (void)__view_dealloc { assert(NO); }

- (void)_view_dealloc {
    if ([UI7TintColors containsKey:self.pointerString]) {
        [UI7TintColors removeObjectForKey:self.pointerString];
    }
    [self __view_dealloc];
}

- (UIColor *)__tintColor { assert(NO); return nil; }

- (UIColor *)_tintColor {
    UIColor *tintColor = [self __tintColor];
    if (tintColor == nil) {
        tintColor = self.superview.tintColor;
        if (tintColor == nil) {
            tintColor = [UI7Kit kit].tintColor;
        }
    }
    return tintColor;
}


@end
