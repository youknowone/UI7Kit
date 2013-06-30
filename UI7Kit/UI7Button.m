//
//  UI7Button.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7Font.h"

#import "UI7Button.h"

#import "UI7KitPrivate.h"

@implementation UIButton (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
+ (id)__buttonWithType:(UIButtonType)buttonType { assert(NO); return nil; }
//- (void)__drawRect:(CGRect)rect { assert(NO); }

- (void)_buttonInitTheme {
    self.titleLabel.font = [UI7Font systemFontOfSize:self.titleLabel.font.pointSize attribute:UI7FontAttributeLight];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    switch (self.buttonType) {
        case UIButtonTypeCustom:
        case UIButtonTypeRoundedRect:
            break;
        case UIButtonTypeDetailDisclosure:
        case UIButtonTypeInfoDark:
        case UIButtonTypeInfoLight: {
            UIImage *image = [UIImage imageNamed:@"UI7ButtonImageInfo"];
            image = [image imageByFilledWithColor:self.tintColor];
            [self setImage:image forState:UIControlStateNormal];
            image = [image imageByFilledWithColor:self.tintColor.highligtedColor];
            [self setImage:image forState:UIControlStateHighlighted];
        }   break;
        case UIButtonTypeContactAdd: {
            UIImage *image = [UIImage imageNamed:@"UI7ButtonImageAdd"];
            image = [image imageByFilledWithColor:self.tintColor];
            [self setImage:image forState:UIControlStateNormal];
            image = [image imageByFilledWithColor:self.tintColor.highligtedColor];
            [self setImage:image forState:UIControlStateHighlighted];
        }   break;
        default:
            break;
    }
}

@end


@implementation UI7Button (UIRoundedRectButton)

- (id)_UIRoundedRectButton_initWithCoder:(NSCoder *)aDecoder {
    if (self != nil && [self.class.name isEqualToString:@"UIRoundedRectButton"]) {
        object_setClass(self, [UI7Button class]);
    }
    self = [UI7Button methodImplementationForSelector:@selector(initWithCoder:)](self, _cmd, aDecoder);
    return self;
}

@end


@implementation UI7Button

+ (void)initialize {
    if (self == [UI7Button class]) {
        Class target = [UIButton class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target classMethodForSelector:@selector(__buttonWithType:)].implementation = [target classMethodForSelector:@selector(buttonWithType:)].implementation;
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
    }
}

+ (void)patch {
    Class target = [UIButton class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [target methodForSelector:@selector(tintColor)].implementation = [target methodForSelector:@selector(_tintColor)].implementation;
    [target classMethodObjectForSelector:@selector(buttonWithType:)].implementation = [self.class classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
    [self exportSelector:@selector(drawRect:) toClass:target];
    [NSClassFromString(@"UIRoundedRectButton") addMethodForSelector:@selector(initWithCoder:) fromMethod:[self methodForSelector:@selector(_UIRoundedRectButton_initWithCoder:)]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _tintColorUpdated];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType {
    if (buttonType == UIButtonTypeRoundedRect) {
        UIButton *button = [self __buttonWithType:UIButtonTypeCustom];
        [button _buttonInitTheme];
        return button;
    }
    return [self __buttonWithType:buttonType];
}

@end


@implementation UI7RoundedRectButton

- (void)_roundedRectButtonInit {
    self.layer.cornerRadius = 6.0;
    self.backgroundColor = self.tintColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:self.tintColor.highligtedColor forState:UIControlStateHighlighted];
    [self setTitleColor:self.tintColor.highligtedColor forState:UIControlStateSelected];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self _roundedRectButtonInit];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self _roundedRectButtonInit];
    return self;
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    self.backgroundColor = tintColor;
}

@end
