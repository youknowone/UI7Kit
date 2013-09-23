//
//  UI7Font.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 22..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"


NSString *const UI7FontTextStyleHeadline = @"UICTFontTextStyleHeadline";
NSString *const UI7FontTextStyleSubheadline = @"UICTFontTextStyleSubhead";
NSString *const UI7FontTextStyleBody = @"UICTFontTextStyleBody";
NSString *const UI7FontTextStyleFootnote = @"UICTFontTextStyleFootnote";
NSString *const UI7FontTextStyleCaption1 = @"UICTFontTextStyleCaption1";
NSString *const UI7FontTextStyleCaption2 = @"UICTFontTextStyleCaption2";


NSString *const UI7FontAttributeNone = nil;
NSString *const UI7FontAttributeUltraLight = @"UltraLight";
NSString *const UI7FontAttributeUltraLightItalic = @"UltraLightItalic";
NSString *const UI7FontAttributeLight = @"Light";
NSString *const UI7FontAttributeLightItalic = @"LightItalic";
NSString *const UI7FontAttributeMedium = @"Medium";
NSString *const UI7FontAttributeItalic = @"Italic";
NSString *const UI7FontAttributeBold = @"Bold";
NSString *const UI7FontAttributeBoldItalic = @"BoldItalic";
NSString *const UI7FontAttributeCondensedBold = @"CondensedBold";
NSString *const UI7FontAttributeCondensedBlack = @"CondensedBlack";


@implementation UIFont (Patch)

+ (UIFont *)__preferredFontForTextStyle:(NSString *)style {
    static NSDictionary *fontAttributes = nil;
    if (fontAttributes == nil) {
        fontAttributes = [@{
                           UIFontTextStyleHeadline: @[@".Helvetica Neue Interface", @16.0],
                           UIFontTextStyleSubheadline: @[@".Helvetica Neue Interface", @14.0],
                           UIFontTextStyleBody: @[@".Helvetica Neue Interface", @16.0],
                           UIFontTextStyleFootnote: @[@".Helvetica Neue Interface", @12.0],
                           UIFontTextStyleCaption1: @[@".Helvetica Neue Interface", @11.0],
                           UIFontTextStyleCaption2: @[@".Helvetica Neue Interface", @11.0],
                          } retain];
    }
    NSArray *fontAttribute = fontAttributes[style];
    return [UIFont fontWithName:@"Helvetica Neue" size:[fontAttribute[1] floatValue]];
}

@end


@implementation UI7Font

+ (void)patch {
    [UIFont addClassMethodForSelector:@selector(preferredFontForTextStyle:) fromMethod:[UIFont classMethodObjectForSelector:@selector(__preferredFontForTextStyle:)]];

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

@implementation UIFont (UI7Kit)

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
