//
//  UI7Slider.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7Color.h"
#import "UI7View.h"

#import "UI7Slider.h"

NSString *UI7SliderMinimumTrackTintColor = @"UI7SliderMinimumTrackTintColor";
NSString *UI7SliderMaximumTrackTintColor = @"UI7SliderMaximumTrackTintColor";

@implementation UISlider (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (UIColor *)__minimumTrackTintColor { assert(NO); return nil; }
- (UIColor *)__maximumTrackTintColor { assert(NO); return nil; }

- (void)_minimumTrackTintColorUpdated {
    UIImage *image = [UIImage imageWithColor:self.minimumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMinimumTrackImage:image forState:UIControlStateNormal];
}

- (void)_maximumTrackTintColorUpdated {
    UIImage *image = [UIImage imageWithColor:self.maximumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMaximumTrackImage:image forState:UIControlStateNormal];
}

- (void)_sliderInit {
    UIImage *image = [UIImage imageNamed:@"UI7SliderThumb"];
    [self setThumbImage:image forState:UIControlStateNormal];
    [self setThumbImage:image forState:UIControlStateHighlighted];

    [self _minimumTrackTintColorUpdated];
    [self _maximumTrackTintColorUpdated];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];

    if (![self associatedObjectForKey:UI7SliderMinimumTrackTintColor]) {
        [self _minimumTrackTintColorUpdated];
    }
}

@end


@implementation UI7Slider

+ (void)initialize {
    if (self == [UI7Slider class]) {
        Class target = [UISlider class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__minimumTrackTintColor) fromSelector:@selector(minimumTrackTintColor)];
        [target copyToSelector:@selector(__maximumTrackTintColor) fromSelector:@selector(maximumTrackTintColor)];
    }
}

+ (void)patch {
    Class target = [UISlider class];

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(minimumTrackTintColor) toClass:target];
    [self exportSelector:@selector(setMinimumTrackTintColor:) toClass:target];
    [self exportSelector:@selector(maximumTrackTintColor) toClass:target];
    [self exportSelector:@selector(setMaximumTrackTintColor:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _sliderInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        self.thumbTintColor = [UIColor whiteColor];
        // NOTE: Becasue built-in -initWithCoder: calls -setMinimumTrackColor: and -setMaximumTrackColor:, additional work is not required.
        [self _sliderInit];
    }
    return self;
}

- (UIColor *)minimumTrackTintColor {
    UIColor *color = [self associatedObjectForKey:UI7SliderMinimumTrackTintColor];
    if (color) {
        return color;
    }
    return self.tintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)tintColor {
    [self setAssociatedObject:tintColor forKey:UI7SliderMinimumTrackTintColor];
    [self _minimumTrackTintColorUpdated];
}

- (UIColor *)maximumTrackTintColor {
    UIColor *color = [self associatedObjectForKey:UI7SliderMaximumTrackTintColor];
    if (color) {
        return color;
    }
    return [UI7Color defaultTrackTintColor];
}

- (void)setMaximumTrackTintColor:(UIColor *)tintColor {
    [self setAssociatedObject:tintColor forKey:UI7SliderMaximumTrackTintColor];
    [self _maximumTrackTintColorUpdated];
}

@end
