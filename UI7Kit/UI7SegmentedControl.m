//
//  UI7SegmentedControl.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 17..
//
//
//  Original source comes from FlatUI by Piotr Bernad.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Piotr Bernad
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7Font.h"
#import "UI7View.h"

#import "UI7SegmentedControl.h"

#import "UI7KitPrivate.h"

CGFloat UI7SegmentedControlHeight = 29.0f;
CGFloat UI7SegmentedControlCellWidthDefault = 80.0f;

@implementation UISegmentedControl (Patch)

- (void)awakeFromNib { [super awakeFromNib]; }

- (id)__initWithItems:(NSArray *)items { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__awakeFromNib { assert(NO); }
- (UIColor *)__tintColor { assert(NO); return nil; }
- (void)__setTintColor:(UIColor *)tintColor { assert(NO); }
- (void)__setFrame:(CGRect)frame { assert(NO); }

- (void)_segmentedControlInit {
    self.layer.cornerRadius = UI7ControlRadius;
    self.layer.borderWidth = 1.0f;

    CGRect frame = self.frame;
    frame.size.height = UI7SegmentedControlHeight;
    self.frame = frame;

    [self _backgroundColorUpdated];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = [super intrinsicContentSize];
    contentSize.height = MAX(29.0f, contentSize.height);
    return contentSize;
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];

    UIColor *tintColor = self.tintColor;
    if (tintColor == nil) return;
    // Set background images

    UIImage *backgroundImage = [UIColor clearColor].image;
    UIImage *selectedBackgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, self.frame.size.height) color:tintColor radius:UI7ControlRadius];
    UIImage *highlightedBackgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, self.frame.size.height) color:[tintColor highligtedColorForBackgroundColor:self.stackedBackgroundColor] radius:UI7ControlRadius];

    NSDictionary *attributes = @{
                                 UITextAttributeFont: [UI7Font systemFontOfSize:13.0 attribute:UI7FontAttributeMedium],
                                 UITextAttributeTextColor: tintColor,
                                 UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                 };
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];

    NSDictionary *highlightedAttributes = @{UITextAttributeTextColor: tintColor};
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];

    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    [self setDividerImage:tintColor.image forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    self.layer.borderColor = tintColor.CGColor;
}

- (void)_backgroundColorUpdated {
    NSDictionary *selectedAttributes = @{UITextAttributeTextColor: self.stackedBackgroundColor};
    [self setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
}

@end


@implementation UI7SegmentedControl

+ (void)initialize {
    if (self == [UI7SegmentedControl class]) {
        Class target = [UISegmentedControl class];

        [target copyToSelector:@selector(__initWithItems:) fromSelector:@selector(initWithItems:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__awakeFromNib) fromSelector:@selector(awakeFromNib)];
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
        [target copyToSelector:@selector(__setTintColor:) fromSelector:@selector(setTintColor:)];
        [target copyToSelector:@selector(__setFrame:) fromSelector:@selector(setFrame:)];
    }
}

+ (void)patch {
    Class target = [UISegmentedControl class];

    [self exportSelector:@selector(initWithItems:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(awakeFromNib) toClass:target];
    [self exportSelector:@selector(setFrame:) toClass:target];
    if (![UIDevice currentDevice].iOS7) {
        [self exportSelector:@selector(tintColor) toClass:target];
        [self exportSelector:@selector(setTintColor:) toClass:target];
    }
}

- (void)awakeFromNib {
    [self __awakeFromNib];
    [self _segmentedControlInit];
}

- (id)initWithItems:(NSArray *)items {
    self = [self __initWithItems:items];
    if (self != nil) {
        [self _segmentedControlInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self != nil) {
        [self _segmentedControlInit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    // keep the minimal size
    if (frame.size.height <= 1.0f) {
        frame.size.height = UI7SegmentedControlHeight;
    }
    if (frame.size.width <= 1.0f) {
        frame.size.width = 1.0f + UI7SegmentedControlCellWidthDefault * self.numberOfSegments;
    }
    [self __setFrame:frame];
}

- (UIColor *)tintColor {
    UIColor *color = [self __tintColor];
    if (color == nil) {
        color = [self _tintColor];
    }
    return color;
}

- (void)setTintColor:(UIColor *)tintColor {
    [self __setTintColor:tintColor];
    [self _tintColorUpdated];
}

@end
