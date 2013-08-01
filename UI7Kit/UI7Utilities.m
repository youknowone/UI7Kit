//
//  UI7Utilities.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Utilities.h"

@implementation UIDevice (iOS7)

- (NSInteger)majorVersion {
    static NSInteger result = -1;
    if (result == -1) {
        NSNumber *majorVersion = [[self.systemVersion componentsSeparatedByString:@"."] objectAtIndex:0];
        result = majorVersion.integerValue;
    }
    return (BOOL)result;
}

- (BOOL)isIOS7 {
    static NSInteger result = -1;
    if (result == -1) {
        result = [self majorVersion] >= 7;
    }
    return (BOOL)result;
}

- (BOOL)needsUI7Kit {
    static NSInteger result = -1;
    if (result == -1) {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        result = ![self isIOS7];
        #else
        result = YES;
        #endif
    }
    return (BOOL)result;
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


const CGFloat UI7ControlRadius = 4.0f;
const CGSize UI7ControlRadiusSize = {4.0f, 4.0f};
const CGFloat UI7ControlRowHeight = 44.0f;

@implementation UIImage (Images)

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
