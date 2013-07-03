//
//  UI7TextField.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 27..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7TextField.h"

@implementation UITextField (Patch)

//- (id)initWithFrame:(CGRect)frame { return [super initWithFrame:frame]; }

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_textFieldInit {
    if (self.borderStyle == UITextBorderStyleRoundedRect) {
        self.borderStyle = UITextBorderStyleNone;
        self.layer.cornerRadius = UI7ControlRadius;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

@end

@implementation UI7TextField

+ (void)initialize {
    if (self == [UI7TextField class]) {
        Class target = [UITextField class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
//        [origin copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UITextField class];

    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
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

@end
