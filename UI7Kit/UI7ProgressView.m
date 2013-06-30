//
//  UI7ProgressView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7Color.h"
#import "UI7View.h"

#import "UI7ProgressView.h"

NSMutableDictionary *UI7ProgressViewTrackTintColors = nil;
NSMutableDictionary *UI7ProgressViewProgressTintColors = nil;

@implementation UIProgressView (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithProgressViewStyle:(UIProgressViewStyle)style { assert(NO); return nil; }

- (void)_progressViewInit {
    self.progressViewStyle = UIProgressViewStyleDefault; // bar type has no difference in iOS7
    [self _trackTintColorUpdated];
    [self _progressTintColorUpdated];
}

- (void)_trackTintColorUpdated {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0, 9.0), NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.trackTintColor set];
    CGContextFillRect(context, CGRectMake(.0, 4.0, 1.0, 2.0));
    UIImage *trackImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.trackImage = trackImage;
}

- (void)_progressTintColorUpdated {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0, 9.0), NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.progressTintColor set];
    CGContextFillRect(context, CGRectMake(.0, 4.0, 1.0, 2.0));
    UIImage *progressImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.progressImage = progressImage;
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    if (![UI7ProgressViewProgressTintColors containsKey:self.pointerString]) {
        [self _progressTintColorUpdated];
    }
}

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    if ([UI7ProgressViewTrackTintColors containsKey:self.pointerString]) {
        [UI7ProgressViewTrackTintColors removeObjectForKey:self.pointerString];
    }
    if ([UI7ProgressViewProgressTintColors containsKey:self.pointerString]) {
        [UI7ProgressViewProgressTintColors removeObjectForKey:self.pointerString];
    }
    [self __dealloc];
}

@end


@implementation UI7ProgressView

+ (void)initialize {
    if (self == [UI7ProgressView class]) {
        Class target = [UIProgressView class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__initWithProgressViewStyle:) fromSelector:@selector(initWithProgressViewStyle:)];
        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    Class target = [UIProgressView class];

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithProgressViewStyle:) toClass:target];
    [self exportSelector:@selector(trackTintColor) toClass:target];
    [self exportSelector:@selector(setTrackTintColor:) toClass:target];
    [self exportSelector:@selector(progressTintColor) toClass:target];
    [self exportSelector:@selector(setProgressTintColor:) toClass:target];
    [self exportSelector:@selector(dealloc) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self != nil) {
        [self _progressViewInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _progressViewInit];
    }
    return self;
}

- (id)initWithProgressViewStyle:(UIProgressViewStyle)style {
    self = [self __initWithProgressViewStyle:style];
    if (self != nil) {
        [self _progressViewInit];
    }
    return self;
}

- (UIColor *)trackTintColor {
    if ([UI7ProgressViewTrackTintColors containsKey:self.pointerString]) {
        return UI7ProgressViewTrackTintColors[self.pointerString];
    }
    return [UI7Color defaultTrackTintColor];
}

- (void)setTrackTintColor:(UIColor *)tintColor {
    if (tintColor) {
        UI7ProgressViewTrackTintColors[self.pointerString] = tintColor;
    } else {
        if ([UI7ProgressViewTrackTintColors containsKey:self.pointerString]) {
            [UI7ProgressViewTrackTintColors removeObjectForKey:self.pointerString];
        }
    }
    [self _trackTintColorUpdated];
}

- (UIColor *)progressTintColor {
    if ([UI7ProgressViewProgressTintColors containsKey:self.pointerString]) {
        return UI7ProgressViewProgressTintColors[self.pointerString];
    }
    return self.tintColor;
}

- (void)setProgressTintColor:(UIColor *)tintColor {
    if (tintColor) {
        UI7ProgressViewProgressTintColors[self.pointerString] = tintColor;
    } else {
        if ([UI7ProgressViewProgressTintColors containsKey:self.pointerString]) {
            [UI7ProgressViewProgressTintColors removeObjectForKey:self.pointerString];
        }
    }
    [self _progressTintColorUpdated];
}

@end
