//
//  UI7KitPrivate.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 20..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

//  Don't access here as much as possible.

#import <UI7Kit/UI7Utilities.h>

UIKIT_EXTERN NSMutableDictionary *UI7TintColors;

@interface UIView (Private)

- (UIColor *)_tintColor;
- (UIColor *)__tintColor;
- (void)_tintColorUpdated; // implement tintColorDidChange to access here.
- (void)_backgroundColorUpdated;

@end


@interface UITableView (Private)

@property(nonatomic,readonly) UITableViewStyle __style;

@end
