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
    NSArray *versionParts = [self.systemVersion componentsSeparatedByString:@"."];
    NSInteger major = [versionParts[0] integerValue];
    return major < 7;
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
