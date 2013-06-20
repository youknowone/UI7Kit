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

- (void)_stepperInit {
    if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]) {
        NSDictionary *backColors = @{
                                     @(UIControlStateNormal): [UIColor clearColor],
                                     @(UIControlStateHighlighted): self.tintColor.highligtedColor,
                                     @(UIControlStateDisabled): [UIColor clearColor],
                                     };
        NSDictionary *titleColors = @{
                                      @(UIControlStateNormal): self.tintColor,
                                      @(UIControlStateHighlighted): self.tintColor.highligtedColor,
                                      @(UIControlStateDisabled): self.tintColor.highligtedColor,
                                      };

        [self setDividerImage:self.tintColor.image
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal];

        for (NSNumber *stateNumber in @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled)]) {
            UIControlState state = (UIControlState)(stateNumber.integerValue);
            UIImage *backgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0, 30.0) color:backColors[stateNumber] radius:4.0];
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
        //        for (CALayer *layer in self.layer.sublayers.reverseObjectEnumerator) {
        //            [layer removeFromSuperlayer];
        //            static int count = 0;
        //            count += 1;
        //            if (count ==3) break;
        //        }
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
