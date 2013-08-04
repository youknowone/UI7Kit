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

@end


@implementation UI7Switch

+ (void)initialize {
    if (self == [UI7Switch class]) {
        Class target = [UISwitch class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UISwitch class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [self release];

    //Reassign self and set to a KLSwitch copying propertie from dummy
    self = (UI7Switch *)[[KLSwitch alloc] initWithCoder:aDecoder];
    if (self != nil) {
        BOOL on = [aDecoder decodeBoolForKey:@"UISwitchOn"];
        [self setOn:on animated:NO];
        if ([aDecoder containsValueForKey:@"UISwitchOnTintColor"]) {
            self.onTintColor = [aDecoder decodeObjectForKey:@"UISwitchOnTintColor"];
        } else {
            self.onTintColor = [UIColor colorWith8bitRed:69 green:215 blue:117 alpha:255];
        }
        if ([aDecoder containsValueForKey:@"UISwitchThumbTintColor"]) {
            self.thumbTintColor = [aDecoder decodeObjectForKey:@"UISwitchThumbTintColor"];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    [self release];
    //Reassign self and set to a KLSwitch copying propertie from dummy
    self = (UI7Switch *)[[KLSwitch alloc] initWithFrame:frame];
    return self;
}
@end
