//
//  UI7Switch.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Switch.h"

#if !defined(UI7SWITCH_KLSWITCH) && !defined(UI7SWITCH_MBSWITCH) && !defined(UI7SWITCH_SEVENSWITCH)
#   define UI7SWITCH_SEVENSWITCH 1
#endif

#if UI7SWITCH_KLSWITCH
#   import <KLSwitch/KLSwitch.h>
#   define UI7SwitchImplementation KLSwitch
#elif UI7SWITCH_MBSWITCH
#   import <MBSwitch/MBSwitch.h>
@interface MBSwitch (Private)
- (void)configure;
@end
#   define UI7SwitchImplementation MBSwitch
#elif UI7SWITCH_SEVENSWITCH
#   import <SevenSwitch/SevenSwitch.h>
#   define UI7SwitchImplementation SevenSwitch
#else
#   error UI7Switch implementation class is missing.
#endif

@implementation UISwitch (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__awakeFromNib { assert(NO); }

@end


@implementation UI7Switch

+ (void)initialize {
    if (self == [UI7Switch class]) {
        Class target = [UISwitch class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        #if UI7SWITCH_MBSWITCH
        [self exportSelector:@selector(awakeFromNib) toClass:[UI7SwitchImplementation class]];
        #endif
    }
}

+ (void)patch {
    Class target = [UISwitch class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *className = self.class.name;
    if ([className isEqual:@"UISwitch"] || [className isEqual:@"UI7Switch"]) {
        [self release];

        //Reassign self and set to a KLSwitch copying propertie from dummy
        self = (UI7Switch *)[[UI7SwitchImplementation alloc] initWithCoder:aDecoder];
        if (self != nil) {
            #if UI7SWITCH_MBSWITCH
            [self configure];
            #endif
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
            CGRect frame = self.frame;
            if (frame.size.width != 51.0f) {
                frame.size.height = 31.0f;
                #if UI7SWITCH_KLSWITCH
                frame.origin.x += 20.0f;
                #elif UI7SWITCH_MBSWITCH
                frame.origin.x += (frame.size.width - 51.0f) / 2;
                #endif
                frame.size.width = 51.0f;
                self.frame = frame;
            }
        }
    } else {
        self = [self __initWithCoder:aDecoder];
    }
    return self;
}

#if UI7SWITCH_MBSWITCH
- (void)awakeFromNib {

}
#endif

- (id)initWithFrame:(CGRect)frame {
    NSString *className = self.class.name;
    if ([className isEqual:@"UISwitch"] || [className isEqual:@"UI7Switch"]) {
        [self release];

        //Reassign self and set to a KLSwitch copying propertie from dummy
        self = (UI7Switch *)[[UI7SwitchImplementation alloc] initWithFrame:frame];
    } else {
        self = [self __initWithFrame:frame];
    }
    return self;
}

@end
