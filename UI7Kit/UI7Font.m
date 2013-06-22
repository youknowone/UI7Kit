//
//  UI7Font.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 22..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"

NSString *UI7FontAttributeNone = nil;
NSString *UI7FontAttributeUltraLight = @"UltraLight";
NSString *UI7FontAttributeUltraLightItalic = @"UltraLightItalic";
NSString *UI7FontAttributeLight = @"Light";
NSString *UI7FontAttributeLightItalic = @"LightItalic";
NSString *UI7FontAttributeMedium = @"Medium";
NSString *UI7FontAttributeItalic = @"Italic";
NSString *UI7FontAttributeBold = @"Bold";
NSString *UI7FontAttributeBoldItalic = @"BoldItalic";
NSString *UI7FontAttributeCondensedBold = @"CondensedBold";
NSString *UI7FontAttributeCondensedBlack = @"CondensedBlack";

@implementation UI7Font

+ (void)patch {
    Class target = [UI7Font class];
    [self exportSelector:@selector(systemFontOfSize:) toClass:target];
    [self exportSelector:@selector(boldSystemFontOfSize:) toClass:target];
    [self exportSelector:@selector(italicSystemFontOfSize:) toClass:target];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [self iOS7SystemFontOfSize:fontSize attribute:UI7FontAttributeNone];
}

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [self iOS7SystemFontOfSize:fontSize attribute:UI7FontAttributeBold];
}

+ (UIFont *)italicSystemFontOfSize:(CGFloat)fontSize {
    return [self iOS7SystemFontOfSize:fontSize attribute:UI7FontAttributeItalic];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize attribute:(NSString *)attribute {
    return [self iOS7SystemFontOfSize:fontSize attribute:attribute];
}

@end


NSString *UI7FontWeightLight = @"Light";
NSString *UI7FontWeightMedium = @"Medium";
NSString *UI7FontWeightBold = @"Bold";

@implementation UIFont (iOS7)

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize attribute:(NSString *)attribute {
    NSString *fontName = attribute ? [@"HelveticaNeue-%@" format:attribute] : @"Helvetica Neue";
    return [UIFont fontWithName:fontName size:fontSize];
}

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize {
    return [self iOS7SystemFontOfSize:fontSize attribute:nil];
}

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize weight:(NSString *)weight {
    return [self iOS7SystemFontOfSize:fontSize attribute:weight];
}

@end
