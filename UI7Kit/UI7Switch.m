//
//  UI7Switch.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Switch.h"
#import <KLSwitch/KLSwitch.h>
@implementation UISwitch (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_switchInit {
   // self.onTintColor = [UIColor colorWith8bitRed:76 green:217 blue:100 alpha:255];
    if ([self respondsToSelector:@selector(onImage)]) {
        self.onImage = [UIImage clearImage];
        self.offImage = [UIImage clearImage];
        self.tintColor = self.tintColor;
        self.thumbTintColor = [UIColor whiteColor];
    }
}
@end

@implementation UI7Switch

+ (void)initialize {
    if (self == [UI7Switch class]) {
        Class origin = [UISwitch class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UISwitch class];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    //Create a dummy to grab IB props from
    UISwitch* dummySwitch = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [dummySwitch _switchInit];
    }
    
    //Reassign self and set to a KLSwitch copying propertie from dummy
    self = (UI7Switch*)[[KLSwitch alloc]
            initWithCoder:aDecoder];
    if (self != nil) {
        self.on = dummySwitch.on;
        self.onTintColor = dummySwitch.onTintColor;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    //Create a dummy to grab IB props from
    UISwitch* dummySwitch = [self __initWithFrame:frame];
    if (self != nil) {
        [dummySwitch _switchInit];
    }
    
    //Reassign self and set to a KLSwitch copying propertie from dummy
    self = (UI7Switch*)[[KLSwitch alloc]
                        initWithFrame:frame];
    if (self != nil) {
        self.on = dummySwitch.on;
        self.onTintColor = dummySwitch.onTintColor;
    }
    return self;
}

@end
