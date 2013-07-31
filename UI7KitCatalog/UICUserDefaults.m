//
//  UICUserDefaults.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 10..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICUserDefaults.h"

@implementation NSUserDefaults (Configutation)

#define UICNumberGetter(KEY, DEFAULT, GETMETHOD) { id v = [self objectForKey:KEY]; if (v == nil) return DEFAULT; return [v GETMETHOD]; }
#define UICNumberSetter(KEY, VALUE) { [self setObject:@(VALUE) forKey:KEY]; [self synchronize]; }

- (BOOL)globalPatch {
    UICNumberGetter(@"GlobalPatch", YES, boolValue);
}

- (void)setGlobalPatch:(BOOL)globalPatch {
    UICNumberSetter(@"GlobalPatch", globalPatch);
}

- (UIBarStyle)globalBarStyle {
    UICNumberGetter(@"GlobalBarStyle", UIBarStyleDefault, integerValue);
}

- (void)setGlobalBarStyle:(UIBarStyle)globalBarStyle {
    UICNumberSetter(@"GlobalBarStyle", globalBarStyle);
}

- (UIColor *)globalTintColor {
    NSNumber *red = [self objectForKey:@"GlobalTintColorRed"];
    NSNumber *green = [self objectForKey:@"GlobalTintColorGreen"];
    NSNumber *blue = [self objectForKey:@"GlobalTintColorBlue"];

    if (red && green && blue) {
        return [UIColor colorWithRed:red.floatValue green:green.floatValue blue:blue.floatValue alpha:1.0f];
    }

    return nil;
}

- (void)setGlobalTintColor:(UIColor *)globalTintColor {
    UIAColorComponents *components = globalTintColor.components;

    [self setObject:@(components.red) forKey:@"GlobalTintColorRed"];
    [self setObject:@(components.green) forKey:@"GlobalTintColorGreen"];
    [self setObject:@(components.blue) forKey:@"GlobalTintColorBlue"];
}

@end
