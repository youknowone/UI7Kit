//
//  UI7KitCore.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 18..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>


@protocol UI7Patch <NSObject>

+ (void)patch;

@optional
+ (void)patchIfNeeded;

@end


@interface UI7Kit : NSObject<UI7Patch>

@property(nonatomic,strong) UIColor *tintColor; // Global Tint
@property(nonatomic,strong) UIColor *backgroundColor; // Background color

+ (void)excludeClassNamesFromAutopatch:(NSArray *)names; // excludes from autopatch
+ (UI7Kit *)kit;

@end
