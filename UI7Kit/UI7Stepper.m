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

@implementation UIStepper (Patch)

- (void)awakeFromNib { [super awakeFromNib]; }

- (id)__init { assert(NO); return nil; }
- (void)__awakeFromNib { assert(NO); }

- (UIColor *)__tintColor { return nil; }

- (UIColor *)_tintColor {
    UIColor *tintColor = [self __tintColor];
    if (tintColor == nil) {
        tintColor = self.superview.tintColor;
    }
    return tintColor;
}

- (void)_stepperInit {
    UIImage *backgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, 40.0f) color:self.tintColor radius:4.0];
    UIImage *highlightedBackgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, 40.0f) color:self.tintColor.highligtedColor radius:4.0];

    if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]) {
        [self setBackgroundImage:[UIImage clearImage]
                        forState:UIControlStateNormal];

        [self setBackgroundImage:backgroundImage
                        forState:UIControlStateSelected];

        [self setBackgroundImage:highlightedBackgroundImage
                        forState:UIControlStateHighlighted];

        [self setBackgroundImage:[UIImage clearImage]
                        forState:UIControlStateDisabled];

        [self setDividerImage:self.tintColor.image
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal];
    }

    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = self.tintColor.CGColor;
}

@end

@implementation UI7Stepper

+ (void)initialize {
    if (self == [UI7Stepper class]) {
        Class origin = [UIStepper class];

        [origin copyToSelector:@selector(__init) fromSelector:@selector(initWithItems:)];
        [origin copyToSelector:@selector(__awakeFromNib) fromSelector:@selector(awakeFromNib)];

        NSAMethod *tintColorMethod = [origin methodForSelector:@selector(tintColor)];
        NSAMethod *viewTintColorMethod = [origin methodForSelector:@selector(_view_tintColor)];
        if (tintColorMethod.implementation != viewTintColorMethod.implementation) {
            [origin methodForSelector:@selector(__tintColor)].implementation = tintColorMethod.implementation;
        } else {
            [origin addMethodForSelector:@selector(tintColor) fromMethod:[origin methodForSelector:@selector(__tintColor)]];
        }
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UIStepper class];

    [source exportSelector:@selector(initWithItems:) toClass:target];
    [source exportSelector:@selector(awakeFromNib) toClass:target];
    [target methodForSelector:@selector(tintColor)].implementation = [target methodForSelector:@selector(_tintColor)].implementation;
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

@end
