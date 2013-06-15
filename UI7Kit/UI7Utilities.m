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
    return [[[self.systemVersion componentsSeparatedByString:@"."] :0] integerValue] < 7;
}

@end


@implementation NSObject (Pointer)

- (NSString *)pointerString {
    return [@"%p" format:self];
}

@end


@implementation NSAClass (MethodCopying)

- (void)copyToSelector:(SEL)toSelector fromSelector:(SEL)fromSelector {
    NSAMethod *toMethod = [self methodObjectForSelector:toSelector];
    NSAMethod *fromMethod = [self methodObjectForSelector:fromSelector];
    toMethod.implementation = fromMethod.implementation;
}

- (void)exportSelector:(SEL)selector toClass:(Class)aClass {
    NSAClass *toClass = [NSAClass classWithClass:aClass];
    NSAMethod *fromMethod = [self methodObjectForSelector:selector];
    NSAMethod *toMethod = [toClass methodObjectForSelector:selector];
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

+ (UIColor *)iOS7ButtonTitleColor {
    return [UIColor colorWithRed:.0 green:.5 blue:1.0 alpha:1.0];
}

+ (UIColor *)iOS7ButtonTitleHighlightedColor {
    return [UIColor colorWith8bitRed:197 green:221 blue:248 alpha:255];
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

@end
