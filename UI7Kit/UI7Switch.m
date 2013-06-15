//
//  UI7Switch.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Switch.h"

@implementation UISwitch (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_switchInit {
    self.onTintColor = [UIColor colorWith8bitRed:76 green:217 blue:100 alpha:255];
    if ([self respondsToSelector:@selector(onImage)]) {
        self.onImage = [UIImage blankImage];
        self.offImage = [UIImage blankImage];
    }
}

@end

@implementation UI7Switch

+ (void)initialize {
    if (self == [UI7Switch class]) {
        NSAClass *origin = [UISwitch classObject];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    NSAClass *source = [self classObject];
    NSAClass *target = [UISwitch classObject];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(initWithFrame:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super __initWithCoder:aDecoder];
    if (self != nil) {
        [self _switchInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self __initWithFrame:frame];
    if (self != nil) {
        [self _switchInit];        
    }
    return self;
}

@end
