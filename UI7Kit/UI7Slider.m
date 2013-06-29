//
//  UI7Slider.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Color.h"
#import "UI7View.h"

#import "UI7Slider.h"

@implementation UISlider (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_sliderInitTheme {
    self.minimumTrackTintColor = self.tintColor;
    self.maximumTrackTintColor = [UI7Color defaultTrackTintColor];
    self.thumbTintColor = [UIColor whiteColor];
}

- (void)_sliderInit {
    UIImage *maximumTrackImage = [UIImage imageWithColor:self.maximumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMaximumTrackImage:maximumTrackImage forState:UIControlStateNormal];
    UIImage *minimumTrackImage = [UIImage imageWithColor:self.minimumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
}

@end


@implementation UI7Slider

+ (void)initialize {
    if (self == [UI7Slider class]) {
        Class origin = [UISlider class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UISlider class];

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
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
        if (![aDecoder containsValueForKey:@"UIMinimumTintColor"]) {
            self.minimumTrackTintColor = self.tintColor;
        }
        if (![aDecoder containsValueForKey:@"UIMaximumTintColor"]) {
            self.maximumTrackTintColor = [UI7Color defaultTrackTintColor];
        }
        if (![aDecoder containsValueForKey:@"UIThumbTintColor"]) {
            self.thumbTintColor = [UIColor whiteColor];
        }
        [self _sliderInit];
    }
    return self;
}

@end
