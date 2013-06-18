//
//  main.m
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Kit.h>
#import "UITAppDelegate.h"

UInt32 UI7RandomColor() {
    UInt32 pal[3] = {arc4random() % 0x20, arc4random() % 0x20 + 0x45, arc4random() % 0x20 + 0xd8};
    static int m[][3] = {
        {0,1,2},
        {0,2,1},
        {1,0,2},
        {1,2,0},
        {2,0,1},
        {2,1,0},
    };
    int o = arc4random() % 6;
    return pal[m[o][0]] << 24 | pal[m[o][1]] << 16 | pal[m[o][2]] << 8 | 0xff;
}

int main(int argc, char *argv[]) {
    @autoreleasepool {
        [UI7Kit patchIfNeeded];
        [[UI7Kit kit] setTintColor:[UIColor colorWith32bitColor:UI7RandomColor()]];
        [[UI7Kit kit] setTintColor:[UIColor colorWith8bitRed:250 green:140 blue:0 alpha:255]];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([UITAppDelegate class]));
    }
}
