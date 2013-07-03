//
//  UI7Tool.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 29..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Tool.h"

@implementation NSCoder (Patch)

+ (void)initialize {
    Class UINibDecoder = NSClassFromString(@"UINibDecoder");
    if (self == UINibDecoder) {
        [self copyToSelector:@selector(__containsValueForKey:) fromSelector:@selector(containsValueForKey:)];
        [self copyToSelector:@selector(containsValueForKey:) fromSelector:@selector(_containsValueForKey:)];
    }
}

- (BOOL)__containsValueForKey:(NSString *)key { assert(NO); return NO; }

- (BOOL)_containsValueForKey:(NSString *)key {
    BOOL r = [self __containsValueForKey:key];
    NSLog(@"coder(%p): contains %d %@", self, r, key);
    return r;
}

@end

@implementation NSKeyedUnarchiver (Patch)

+ (void)initialize {
    if (self == [NSKeyedUnarchiver class]) {
        [self copyToSelector:@selector(__containsValueForKey:) fromSelector:@selector(containsValueForKey:)];
        [self copyToSelector:@selector(containsValueForKey:) fromSelector:@selector(_containsValueForKey:)];
    }
}

- (BOOL)__containsValueForKey:(NSString *)key { assert(NO); return NO; }

- (BOOL)_containsValueForKey:(NSString *)key {
    BOOL r = [self __containsValueForKey:key];
    NSLog(@"coder(%p): contains %d %@", self, r, key);
    return r;
}

@end
