//
//  UI7Color.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 29..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UI7Kit)

- (UIColor *)highligtedColorForBackgroundColor:(UIColor *)backgroundColor;
- (UIColor *)highligtedColor;

@end


@interface UI7Color : UIColor

+ (UIColor *)defaultBarColor;
+ (UIColor *)blackBarColor;

+ (UIColor *)defaultBackgroundColor;
+ (UIColor *)defaultTintColor;
+ (UIColor *)defaultEmphasizedColor;
+ (UIColor *)defaultTrackTintColor;
+ (UIColor *)groupedTableViewSectionBackgroundColor;

@end
