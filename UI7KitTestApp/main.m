//
//  main.m
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Kit.h>
#import "UITAppDelegate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        UI7KitPatchAll(NO);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([UITAppDelegate class]));
    }
}
