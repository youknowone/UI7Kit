//
//  UI7ProgressView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UI7View.h"

#import "UI7ProgressView.h"

@implementation UIProgressView (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_progressViewInit {
    self.progressTintColor = self.tintColor;
    self.trackTintColor = [UIColor colorWith8bitWhite:183 alpha:255];

    UIGraphicsBeginImageContext(CGSizeMake(1.0, 9.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.trackTintColor set];
    CGContextFillRect(context, CGRectMake(.0, 4.0, 1.0, 2.0));
    UIImage *trackImage = UIGraphicsGetImageFromCurrentImageContext();
    [self.progressTintColor set];
    CGContextFillRect(context, CGRectMake(.0, 4.0, 1.0, 2.0));
    UIImage *progressImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.trackImage = trackImage;
    self.progressImage = progressImage;
}

@end


@implementation UI7ProgressView

+ (void)initialize {
    if (self == [UI7ProgressView class]) {
        Class origin = [UIProgressView class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class origin = [self class];
    Class target = [UIProgressView class];

    [origin exportSelector:@selector(initWithFrame:) toClass:target];
    [origin exportSelector:@selector(initWithCoder:) toClass:target];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
