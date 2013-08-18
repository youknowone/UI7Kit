//
//  UI7Stepper.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 18..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UI7View.h"

#import "UI7Stepper.h"

#import "UI7KitPrivate.h"


@implementation UIStepper (Patch)

- (void)awakeFromNib { [super awakeFromNib]; }

- (id)__init { assert(NO); return nil; }
- (void)__awakeFromNib { assert(NO); }
- (UIColor *)__tintColor { assert(NO); return nil; }
- (void)__setTintColor:(UIColor *)color { assert(NO); }

- (void)_stepperInit {
    self.layer.cornerRadius = UI7ControlRadius;
    self.layer.borderWidth = 1.0f;
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    UIColor *tintColor = self.tintColor;
    if (tintColor == nil) return;

    if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]) {
        NSDictionary *backColors = @{
                                     @(UIControlStateNormal): [UIColor clearColor],
                                     @(UIControlStateHighlighted): tintColor.highligtedColor,
                                     @(UIControlStateDisabled): [UIColor clearColor],
                                     };
        NSDictionary *titleColors = @{
                                      @(UIControlStateNormal): tintColor,
                                      @(UIControlStateHighlighted): tintColor.highligtedColor,
                                      @(UIControlStateDisabled): tintColor.highligtedColor,
                                      };

        [self setDividerImage:tintColor.image forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];

        for (NSNumber *stateNumber in @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled)]) {
            UIControlState state = (UIControlState)(stateNumber.integerValue);
            UIImage *backgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0, 30.0) color:backColors[stateNumber] radius:UI7ControlRadius];
            [self setBackgroundImage:backgroundImage forState:state];
            UIImage *image;
            image = [self incrementImageForState:state];
            if (image) {
                [self setIncrementImage:[image imageByFilledWithColor:titleColors[stateNumber]] forState:state];
            }
            image = [self decrementImageForState:state];
            if (image) {
                [self setDecrementImage:[image imageByFilledWithColor:titleColors[stateNumber]] forState:state];
            }
        }
    } else {
        // iOS5
        //        for (CALayer *layer in self.layer.sublayers.reverseObjectEnumerator) {
        //            [layer removeFromSuperlayer];
        //            static int count = 0;
        //            count += 1;
        //            if (count ==3) break;
        //        }
    }

    self.layer.borderColor = tintColor.CGColor;
}

@end

@implementation UI7Stepper

+ (void)initialize {
    if (self == [UI7Stepper class]) {
        Class target = [UIStepper class];

        [target copyToSelector:@selector(__init) fromSelector:@selector(initWithItems:)];
        [target copyToSelector:@selector(__awakeFromNib) fromSelector:@selector(awakeFromNib)];

        if ([UIDevice currentDevice].majorVersion == 6) {
            [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
            [target copyToSelector:@selector(__setTintColor:) fromSelector:@selector(setTintColor:)];
        }
    }
}

+ (void)patch {
    Class target = [UIStepper class];

    [self exportSelector:@selector(initWithItems:) toClass:target];
    [self exportSelector:@selector(awakeFromNib) toClass:target];
    if (![UIDevice currentDevice].iOS7) {
        [target methodForSelector:@selector(tintColor)].implementation = [target methodForSelector:@selector(_tintColor)].implementation;
        [target methodForSelector:@selector(setTintColor:)].implementation = [target methodForSelector:@selector(_setTintColor:)].implementation;
    }
}

- (void)awakeFromNib {
    [self __awakeFromNib];
    [self _stepperInit];
}

- (id)init {
    self = [self __init];
    if (self != nil) {
        [self _stepperInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self _stepperInit];
    }
    return self;
}

- (UIColor *)tintColor {
    return [super _tintColor];
}

- (void)setTintColor:(UIColor *)color {
    [super _setTintColor:color];
}

@end
