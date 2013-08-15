//
//  UICUserDefaults.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 10..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UICUserDefaults [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (Configuration)

@property(nonatomic) BOOL globalPatch;
@property(nonatomic) UIBarStyle globalBarStyle;
@property(nonatomic) UIColor *globalTintColor;
@property(nonatomic) UIColor *globalBackgroundColor;

@end
