//
//  UI7KitPrivate.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 20..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

//  Don't access here as much as possible.

#import <UI7Kit/UI7Utilities.h>

UIKIT_EXTERN NSString *UI7AppearanceSuperview;

@interface UIView (UI7View)

- (UIColor *)_current_tintColor; // tint color of current layer.
- (UIColor *)_tintColor;
- (void)_setTintColor:(UIColor *)color;
- (void)_tintColorUpdated; // implement tintColorDidChange to access here.
- (void)_backgroundColorUpdated;

@end


@interface UINavigationItem (UI7NavigationItem)

- (void)_tintColorUpdated; // implement tintColorDidChange to access here.

@end


@interface UIBarButtonItem (UI7BarButtonItem)

@property(assign) id appearanceSuperview;
- (void)_tintColorUpdated; // implement tintColorDidChange to access here.

@end


@interface UITabBarItem (UI7TabBarItem)

@property(assign) id appearanceSuperview;
- (void)_tintColorUpdated; // implement tintColorDidChange to access here.

@end


@interface UITableView (UI7TableView)

@property(nonatomic,readonly) UITableViewStyle __style;

@end
