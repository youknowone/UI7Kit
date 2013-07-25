//
//  UI7KitCore.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 18..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitCore.h"
#import "UI7Color.h"

#import "UI7Utilities.h"

@implementation UI7Kit

@synthesize tintColor=_tintColor;
@synthesize backgroundColor=_backgroundColor;

UI7Kit *UI7KitSharedObject = nil;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.tintColor = [UI7Color defaultTintColor];
        self.backgroundColor = [UI7Color defaultBackgroundColor];
    }
    return self;
}

- (void)dealloc {
    self.tintColor = nil;
    self.backgroundColor = nil;
    [super dealloc];
}

+ (UI7Kit *)kit {
    return UI7KitSharedObject;
}

+ (void)initialize {
    if (self == [UI7Kit class]) {
        UI7KitSharedObject = [[UI7Kit alloc] init];
    }
}

+ (void)patch {
    for (NSString *className in @[
         @"UI7Font",
         @"UI7View",
         @"UI7ViewController",
         @"UI7AlertView",
         @"UI7ActionSheet",
         @"UI7BarButtonItem",
         @"UI7NavigationBar",
         @"UI7NavigationItem",
         @"UI7NavigationController",
         @"UI7TabBar",
         @"UI7TabBarItem",
         @"UI7Toolbar",
         @"UI7SearchBar",
         @"UI7TableView",
         @"UI7TableViewCell",
         @"UI7Button",
         @"UI7Switch",
         @"UI7TextField",
         @"UI7SegmentedControl",
         @"UI7Stepper",
         @"UI7Slider",
         @"UI7ProgressView",
         ]) {
        Class class = NSClassFromString(className);
        [class patch];
    }
}

@end


@implementation NSObject (UI7KitPatch)

+ (void)patchIfNeeded {
    if ([[UIDevice currentDevice] needsUI7Kit]) {
        [(id<UI7Patch>)self patch];
    }
}

@end
