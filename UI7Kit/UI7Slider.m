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

NSMutableDictionary *UI7SliderMinimumTrackTintColors = nil;
NSMutableDictionary *UI7SliderMaximumTrackTintColors = nil;

@implementation UISlider (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_sliderInitTheme {
    self.thumbTintColor = [UIColor whiteColor];
}

- (void)_minimumTrackTintColorUpdated {
    UIImage *image = [UIImage imageWithColor:self.minimumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMinimumTrackImage:image forState:UIControlStateNormal];
}

- (void)_maximumTrackTintColorUpdated {
    UIImage *image = [UIImage imageWithColor:self.maximumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMaximumTrackImage:image forState:UIControlStateNormal];
}

- (void)_sliderInit {
    [self _minimumTrackTintColorUpdated];
    [self _maximumTrackTintColorUpdated];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];

    if (![UI7SliderMinimumTrackTintColors containsKey:self.pointerString]) {
        [self _minimumTrackTintColorUpdated];
    }
}

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    if ([UI7SliderMinimumTrackTintColors containsKey:self.pointerString]) {
        [UI7SliderMinimumTrackTintColors removeObjectForKey:self.pointerString];
    }
    if ([UI7SliderMaximumTrackTintColors containsKey:self.pointerString]) {
        [UI7SliderMaximumTrackTintColors removeObjectForKey:self.pointerString];
    }
    [self __dealloc];
}


@end


@implementation UI7Slider

+ (void)initialize {
    if (self == [UI7Slider class]) {
        UI7SliderMinimumTrackTintColors = [[NSMutableDictionary alloc] init];
        UI7SliderMaximumTrackTintColors = [[NSMutableDictionary alloc] init];

        Class target = [UISlider class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
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

- (void)dealloc {
    [self _dealloc];
    return
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self __initWithFrame:frame];
    if (self) {
        [self _sliderInitTheme];
        [self _sliderInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        if (![aDecoder containsValueForKey:@"UIThumbTintColor"]) {
            self.thumbTintColor = [UIColor whiteColor];
        }
        [self _sliderInit];
    }
    return self;
}

- (UIColor *)minimumTrackTintColor {
    if ([UI7SliderMinimumTrackTintColors containsKey:self.pointerString]) {
        return UI7SliderMinimumTrackTintColors[self.pointerString];
    }
    return self.tintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)tintColor {
    if (tintColor) {
        UI7SliderMinimumTrackTintColors[self.pointerString] = tintColor;
    } else {
        if ([UI7SliderMinimumTrackTintColors containsKey:self.pointerString]) {
            [UI7SliderMinimumTrackTintColors removeObjectForKey:self.pointerString];
        }
    }
    [self _minimumTrackTintColorUpdated];
}

- (UIColor *)maximumTrackTintColor {
    if ([UI7SliderMaximumTrackTintColors containsKey:self.pointerString]) {
        return UI7SliderMaximumTrackTintColors[self.pointerString];
    }
    return [UI7Color defaultTrackTintColor];
}

- (void)setMaximumTrackTintColor:(UIColor *)tintColor {
    if (tintColor) {
        UI7SliderMaximumTrackTintColors[self.pointerString] = tintColor;
    } else {
        if ([UI7SliderMaximumTrackTintColors containsKey:self.pointerString]) {
            [UI7SliderMaximumTrackTintColors removeObjectForKey:self.pointerString];
        }
    }
    [self _maximumTrackTintColorUpdated];
}

@end
