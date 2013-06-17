//
//  UI7Button.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Button.h"

@implementation UIButton (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
+ (id)__buttonWithType:(UIButtonType)buttonType { assert(NO); return nil; }
//- (void)__drawRect:(CGRect)rect { assert(NO); }

- (void)_buttonInit {
    if (self.buttonType == UIButtonTypeRoundedRect) {
        self.titleLabel.font = [UIFont iOS7SystemFontOfSize:self.titleLabel.font.pointSize weight:@"Light"];
        [self setBackgroundImage:[UIImage blankImage] forState:UIControlStateNormal];
    }
}

@end


@implementation UI7Button

+ (void)initialize {
    if (self == [UI7Button class]) {
        NSAClass *origin = [UIButton classObject];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin classMethodObjectForSelector:@selector(__buttonWithType:)].implementation = [origin classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
//        [origin copyToSelector:@selector(__drawRect:) fromSelector:@selector(drawRect:)];
    }
}

+ (void)patch {
    NSAClass *source = [self classObject];
    NSAClass *target = [UIButton classObject];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [target classMethodObjectForSelector:@selector(buttonWithType:)].implementation = [source classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
    [source exportSelector:@selector(drawRect:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self.buttonType == UIButtonTypeRoundedRect) {
        // TODO: no idea yet.
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType {
    if (buttonType == UIButtonTypeRoundedRect) {
        UIButton *button = [self __buttonWithType:UIButtonTypeCustom];
        [button _buttonInit];
        return button;
    }
    return [self __buttonWithType:buttonType];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"buh");
}

@end
