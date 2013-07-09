//
//  main.m
//  UI7KitCatalog
//
//  Created by Jeong YunWon on 13. 7. 8..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Kit.h>

#import "UICUserDefaults.h"
#import "UICAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        if (UICUserDefaults.globalPatch) {
            [UI7Kit patchIfNeeded];
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([UICAppDelegate class]));
    }
}
