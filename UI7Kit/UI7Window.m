//
//  UI7Window.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 24..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7View.h"
#import "UI7Window.h"

@implementation UIWindow (Private)

- (UIColor *)tintColor {
    UIColor *color = [super _current_tintColor];
    if (color == nil) {
        color = [UI7Kit kit].tintColor;
    }
    return color;
}

@end


@implementation UI7Window


@end
