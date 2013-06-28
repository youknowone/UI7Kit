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

@implementation UISegmentedControl (Patch)

- (void)awakeFromNib { [super awakeFromNib]; }

- (id)__initWithItems:(NSArray *)items { assert(NO); return nil; }
- (void)__awakeFromNib { assert(NO); }

- (void)_segmentedControlInit {
    // Set background images

    UIImage *backgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, 40.0f) color:self.tintColor radius:4.0];
    UIImage *selectedBackgroundImage = [UIImage roundedImageWithSize:CGSizeMake(10.0f, 40.0f) color:[UIColor clearColor] radius:UI7ControlRadius];

    NSDictionary *attributes = @{
                                 UITextAttributeFont: [UI7Font systemFontOfSize:13.0 attribute:UI7FontAttributeMedium],
                                 UITextAttributeTextColor: self.tintColor,
                                 UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                 };
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];

    NSDictionary *highlightedAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];

    [self setBackgroundImage:selectedBackgroundImage
                    forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];

    [self setBackgroundImage:backgroundImage
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];

    [self setDividerImage:self.tintColor.image
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];

    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = self.tintColor.CGColor;
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,29);
}

@end


@implementation UI7SegmentedControl

+ (void)initialize {
    if (self == [UI7SegmentedControl class]) {
        Class origin = [UISegmentedControl class];

        [origin copyToSelector:@selector(__initWithItems:) fromSelector:@selector(initWithItems:)];
        [origin copyToSelector:@selector(__awakeFromNib) fromSelector:@selector(awakeFromNib)];
        [origin copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UISegmentedControl class];

    [source exportSelector:@selector(initWithItems:) toClass:target];
    [source exportSelector:@selector(awakeFromNib) toClass:target];
    [target methodForSelector:@selector(tintColor)].implementation = [target methodForSelector:@selector(_tintColor)].implementation;
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
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self _segmentedControlInit];
    }
    return self;
}

- (UIColor *)tintColor {
    return [super _tintColor];
}

@end
