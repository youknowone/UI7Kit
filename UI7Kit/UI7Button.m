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
        NSAClass *targetClass = [NSAClass classWithClass:[UIButton class]];
        [targetClass copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [targetClass classMethodObjectForSelector:@selector(__buttonWithType:)].implementation = [targetClass classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[UI7Button class]];
    NSAClass *targetClass = [NSAClass classWithClass:[UIButton class]];
    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass.class];
    [targetClass classMethodObjectForSelector:@selector(buttonWithType:)].implementation = [sourceClass classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
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

@end
