//
//  UI7TextField.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 27..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7TextField.h"

NSMutableDictionary *UI7TextFieldBorderStyleIsBordered = nil;

@implementation UITextField (Patch)

//- (id)initWithFrame:(CGRect)frame { return [super initWithFrame:frame]; }

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (UITextBorderStyle)__borderStyle { assert(NO); return 0; }
- (void)__setBorderStyle:(UITextBorderStyle)borderStyle { assert(NO); }
- (CGRect)__textRectForBounds:(CGRect)bounds { assert(NO); return CGRectZero; }
- (CGRect)__editingRectForBounds:(CGRect)bounds { assert(NO); return CGRectZero; }
- (void)__dealloc { assert(NO); }

- (void)_dealloc {
    if ([UI7TextFieldBorderStyleIsBordered containsKey:self.pointerString]) {
        [UI7TextFieldBorderStyleIsBordered removeObjectForKey:self.pointerString];
    }
    [self __dealloc];
}

- (void)_textFieldInit {

}

@end

@implementation UI7TextField

+ (void)initialize {
    if (self == [UI7TextField class]) {
        UI7TextFieldBorderStyleIsBordered = [[NSMutableDictionary alloc] init];

        Class target = [UITextField class];

        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
//        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__borderStyle) fromSelector:@selector(borderStyle)];
        [target copyToSelector:@selector(__setBorderStyle:) fromSelector:@selector(setBorderStyle:)];
        [target copyToSelector:@selector(__textRectForBounds:) fromSelector:@selector(textRectForBounds:)];
        [target copyToSelector:@selector(__editingRectForBounds:) fromSelector:@selector(editingRectForBounds:)];
    }
}

+ (void)patch {
    Class target = [UITextField class];

    [self exportSelector:@selector(dealloc) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(borderStyle) toClass:target];
    [self exportSelector:@selector(setBorderStyle:) toClass:target];
    [self exportSelector:@selector(textRectForBounds:) toClass:target];
    [self exportSelector:@selector(editingRectForBounds:) toClass:target];
}

- (void)dealloc {
    [self _dealloc];
    return;
    [super dealloc];
}

//- (id)initWithFrame:(CGRect)frame {
//    self = [self __initWithFrame:frame];
//    if (self) {
//        [self _textFieldInit];
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self) {
        [self _textFieldInit];
    }
    return self;
}

- (void)setBorderStyle:(UITextBorderStyle)borderStyle {
    if (borderStyle == UITextBorderStyleRoundedRect) {
        [UI7TextFieldBorderStyleIsBordered setObject:@(YES) forKey:self.pointerString];
        [self __setBorderStyle:UITextBorderStyleNone];
        self.layer.cornerRadius = UI7ControlRadius;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else {
        if ([UI7TextFieldBorderStyleIsBordered containsKey:self.pointerString]) {
            self.layer.cornerRadius = .0;
            self.layer.borderWidth = .0;
            self.layer.borderColor = [UIColor clearColor].CGColor;
            [UI7TextFieldBorderStyleIsBordered removeObjectForKey:self.pointerString];
        }
        [self __setBorderStyle:borderStyle];
    }
}

- (UITextBorderStyle)borderStyle {
    if ([UI7TextFieldBorderStyleIsBordered containsKey:self.pointerString]) {
        return UITextBorderStyleRoundedRect;
    }
    return [self __borderStyle];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if ([UI7TextFieldBorderStyleIsBordered containsKey:self.pointerString]) {
        return CGRectInset(bounds, 8.0f, UI7ControlRadius);
    }
    return [self __textRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if ([UI7TextFieldBorderStyleIsBordered containsKey:self.pointerString]) {
        return CGRectInset(bounds, 8.0f, UI7ControlRadius);
    }
    return [self __editingRectForBounds:bounds];
}

@end
