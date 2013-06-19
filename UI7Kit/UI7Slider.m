//
//  UI7Slider.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7View.h"

#import "UI7Slider.h"

@implementation UISlider (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_sliderInit {
    self.minimumTrackTintColor = self.tintColor;
    self.maximumTrackTintColor = [UIColor colorWith8bitWhite:183 alpha:255];
    self.thumbTintColor = [UIColor whiteColor];

    UIImage *maximumTrackImage = [UIImage imageWithColor:self.maximumTrackTintColor size:CGSizeMake(1.0, 2.0)];
    [self setMaximumTrackImage:maximumTrackImage forState:UIControlStateNormal];
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
    Class origin = [self class];
    Class target = [UISlider class];

    [origin exportSelector:@selector(initWithFrame:) toClass:target];
    [origin exportSelector:@selector(initWithCoder:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self __initWithFrame:frame];
    if (self) {
        [self _sliderInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _sliderInit];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
