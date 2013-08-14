//
//  UI7Color.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 29..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>
#import "UI7Color.h"

@implementation UIColor (UI7Kit)

- (UIColor *)highligtedColorForBackgroundColor:(UIColor *)backgroundColor {
    return [[self mixedColorWithColor:backgroundColor ratio:0.25] colorWithAlpha:self.components.alpha];
}

- (UIColor *)highligtedColor {
    return [self highligtedColorForBackgroundColor:[UIColor whiteColor]];
}

@end


@implementation UI7Color

+ (UIColor *)defaultBarColor {
    return [UIColor colorWith8bitWhite:255 alpha:250];
}

+ (UIColor *)blackBarColor {
    return [UIColor colorWith8bitWhite:90 alpha:250];
}

+ (UIColor *)defaultBackgroundColor {
    return [UIColor colorWith8bitWhite:248 alpha:255];
}

+ (UIColor *)defaultTintColor {
    return [UIColor colorWith8bitRed:0 green:126 blue:245 alpha:255];
}

+ (UIColor *)defaultEmphasizedColor {
    return [UIColor colorWith8bitRed:255 green:69 blue:55 alpha:255];
}

+ (UIColor *)defaultTrackTintColor {
    return [UIColor colorWith8bitWhite:183 alpha:255];
}

+ (UIColor *)groupedTableViewSectionBackgroundColor {
    return [UIColor colorWith8bitRed:239 green:239 blue:244 alpha:255];
}

@end
