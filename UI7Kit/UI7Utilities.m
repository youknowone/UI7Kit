//
//  UI7Utilities.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Utilities.h"

@implementation UIDevice (iOS7)

- (BOOL)needsUI7Kit {
    return [[self.systemVersion componentsSeparatedByString:@"."][0] integerValue] < 7;
}

@end


@implementation NSObject (Pointer)

- (NSString *)pointerString {
    return [@"%p" format:self];
}

@end


@implementation NSObject (MethodCopying)

+ (void)copyToSelector:(SEL)toSelector fromSelector:(SEL)fromSelector {
    NSAMethod *toMethod = [self methodForSelector:toSelector];
    NSAMethod *fromMethod = [self methodForSelector:fromSelector];
    toMethod.implementation = fromMethod.implementation;
}

+ (void)exportSelector:(SEL)selector toClass:(Class )toClass {
    NSAMethod *fromMethod = [self methodForSelector:selector];
    NSAMethod *toMethod = [toClass methodForSelector:selector];
    toMethod.implementation = fromMethod.implementation;
}

@end


NSString *UI7FontWeightLight = @"Light";
NSString *UI7FontWeightMedium = @"Medium";
NSString *UI7FontWeightBold = @"Bold";

@implementation UIColor (iOS7)

+ (UIColor *)iOS7BackgroundColor {
    return [UIColor colorWithWhite:248/255.0f alpha:1.0];
}

+ (UIColor *)iOS7ButtonTitleHighlightedColor {
    return [UIColor colorWith8bitRed:197 green:221 blue:248 alpha:255];
}

+ (UIColor *)iOS7ButtonTitleEmphasizedColor {
    return [UIColor colorWith8bitRed:255 green:69 blue:55 alpha:255];
}

+ (UIColor *)iOS7ButtonTitleEmphasizedHighlightedColor {
    return [UIColor colorWith8bitRed:197 green:221 blue:248 alpha:255]; // FIXME
}

@end


@implementation UIFont (iOS7)

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Helvetica Neue" size:fontSize];
}

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize weight:(NSString *)weight {
    return [UIFont fontWithName:[@"HelveticaNeue-%@" format:weight] size:fontSize];
}

@end

const CGFloat UI7ControlRadius = 6.0;

@implementation UIImage (Images)

+ (UIImage *)blankImage {
    static UIImage *image = nil;
    if (image == nil) {
        image = [[UIImage imageNamed:@"UI7Blank"] retain];
    }
    return image;
}

- (UIImageView *)view {
    return [[[UIImageView alloc] initWithImage:self] autorelease];
}

+ (UIImage *)roundedImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius {
    CGRect rect = CGRectZero;
    rect.size = size;

    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];

    return [UIImage imageWithBezierPath:path color:color backgroundColor:color];
}

@end
