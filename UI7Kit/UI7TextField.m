//
//  UI7TextField.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 27..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7TextField.h"

NSString *UI7TextFieldBorderStyleIsBordered = @"UI7TextFieldBorderStyleIsBordered";

@implementation UITextField (Patch)

//- (id)initWithFrame:(CGRect)frame { return [super initWithFrame:frame]; }

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (UITextBorderStyle)__borderStyle { assert(NO); return 0; }
- (void)__setBorderStyle:(UITextBorderStyle)borderStyle { assert(NO); }
- (CGRect)__textRectForBounds:(CGRect)bounds { assert(NO); return CGRectZero; }
- (CGRect)__editingRectForBounds:(CGRect)bounds { assert(NO); return CGRectZero; }

- (void)_textFieldInit {

}

@end

@implementation UI7TextField

+ (void)initialize {
    if (self == [UI7TextField class]) {
        Class target = [UITextField class];

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

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(borderStyle) toClass:target];
    [self exportSelector:@selector(setBorderStyle:) toClass:target];
    [self exportSelector:@selector(textRectForBounds:) toClass:target];
    [self exportSelector:@selector(editingRectForBounds:) toClass:target];
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
        [self setAssociatedObject:@(YES) forKey:UI7TextFieldBorderStyleIsBordered];
        [self __setBorderStyle:UITextBorderStyleNone];
        self.layer.cornerRadius = UI7ControlRadius;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else {
        if ([self associatedObjectForKey:UI7TextFieldBorderStyleIsBordered]) {
            self.layer.cornerRadius = .0;
            self.layer.borderWidth = .0;
            self.layer.borderColor = [UIColor clearColor].CGColor;
            [self removeAssociatedObjectForKey:UI7TextFieldBorderStyleIsBordered];
        }
        [self __setBorderStyle:borderStyle];
    }
}

- (UITextBorderStyle)borderStyle {
    if ([self associatedObjectForKey:UI7TextFieldBorderStyleIsBordered]) {
        return UITextBorderStyleRoundedRect;
    }
    return [self __borderStyle];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [self __textRectForBounds:bounds];
    if ([self associatedObjectForKey:UI7TextFieldBorderStyleIsBordered]) {
        rect = CGRectInset(rect, 8.0f, UI7ControlRadius);
    }
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [self __editingRectForBounds:bounds];
    if ([self associatedObjectForKey:UI7TextFieldBorderStyleIsBordered]) {
        rect = CGRectInset(rect, 8.0f, UI7ControlRadius);
    }
    return rect;
}

@end
