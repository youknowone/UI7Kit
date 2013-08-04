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
        [self copyToSelector:@selector(__decodeObjectForKey:) fromSelector:@selector(decodeObjectForKey:)];
        [self copyToSelector:@selector(decodeObjectForKey:) fromSelector:@selector(_decodeObjectForKey:)];
        [self copyToSelector:@selector(__decodeValueOfObjCType:at:) fromSelector:@selector(decodeValueOfObjCType:at:)];
        [self copyToSelector:@selector(decodeValueOfObjCType:at:) fromSelector:@selector(_decodeValueOfObjCType:at:)];
    }
}

- (BOOL)__containsValueForKey:(NSString *)key { assert(NO); return NO; }

- (BOOL)_containsValueForKey:(NSString *)key {
    BOOL r = [self __containsValueForKey:key];
    NSLog(@"coder(%p): contains %d for %@", self, r, key);
    return r;
}

- (id)__decodeObjectForKey:(NSString *)key { assert(NO); return NO; }

- (id)_decodeObjectForKey:(NSString *)key {
    id r = [self __decodeObjectForKey:key];
    NSLog(@"coder(%p): result %@ for %@", self, r, key);
    return r;
}


- (void)__decodeValueOfObjCType:(const char *)type at:(void *)data { assert(NO); }

- (void)_decodeValueOfObjCType:(const char *)type at:(void *)data {
    [self _decodeValueOfObjCType:type at:data];
    NSLog(@"coder(%p): contains %s", self, type);
}

@end
