//
//  UI7Button.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UI7KitPrivate.h"
#import "UI7View.h"
#import "UI7Font.h"

#import "UI7Button.h"

@interface NSObject (UI7ButtonContent)

@property(retain) NSAttributedString * attributedTitle;
@property(retain) UIImage *background;
@property(retain) UIImage *image;
@property(readonly) BOOL isEmpty;
@property(retain) UIColor *shadowColor;
@property(retain) NSString *title;
@property(retain) UIColor *titleColor;

@end


@interface UIButton (Accessor)

@property(nonatomic,retain,setter=___setTextTitleColor:) UIColor *___textTitleColor;
@property(nonatomic,retain,setter=___setBackgroundColor:) UIColor *___backgroundColor;

@end


@implementation UIButton (Accessor)

- (UIColor *)___textTitleColor {
    return [self associatedObjectForKey:@"UI7ButtonTextTitleColor"];
}

- (void)___setTextTitleColor:(UIColor *)color {
    [self setAssociatedObject:color forKey:@"UI7ButtonTextTitleColor"];
}

- (UIColor *)___backgroundColor {
    return [self associatedObjectForKey:@"UI7ButtonBackgroundColor"];
}

- (void)___setBackgroundColor:(UIColor *)color {
    [self setAssociatedObject:color forKey:@"UI7ButtonBackgroundColor"];
}

@end


@implementation UIButton (Patch)

UIColor *UI7ButtonDefaultTitleColor = nil;

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
+ (id)__buttonWithType:(UIButtonType)buttonType { assert(NO); return nil; }
- (void)__setTitleColor:(UIColor *)color forState:(UIControlState)state { assert(NO); }
- (void)__setBackgroundColor:(UIColor *)backgroundColor { assert(NO); }
- (UIColor *)__tintColor { assert(NO); return nil; }
- (void)__setTintColor:(UIColor *)tintColor { assert(NO); }
//- (void)__drawRect:(CGRect)rect { assert(NO); }

- (void)_buttonInitTheme {
    self.titleLabel.font = [UI7Font systemFontOfSize:[UIFont buttonFontSize] attribute:UI7FontAttributeLight];
}

- (void)_tintColorUpdated {
    [super _tintColorUpdated];
    switch (self.buttonType) {
        case UIButtonTypeCustom:
        case UIButtonTypeRoundedRect: {
            UIColor *textTitleColor = self.___textTitleColor;
            if (textTitleColor == nil) {
                textTitleColor = self.tintColor;
            }
            [self __setTitleColor:textTitleColor forState:UIControlStateNormal];
            UIColor *highlightedTextTitleColor = textTitleColor.highligtedColor;
            [self __setTitleColor:highlightedTextTitleColor forState:UIControlStateHighlighted];
            [self __setTitleColor:highlightedTextTitleColor forState:UIControlStateSelected];
        }   break;
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
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target classMethodObjectForSelector:@selector(__buttonWithType:)].implementation = [target classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
        [target copyToSelector:@selector(__setTitleColor:forState:) fromSelector:@selector(setTitleColor:forState:)];
        [target copyToSelector:@selector(__setBackgroundColor:) fromSelector:@selector(setBackgroundColor:)];
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
        [target copyToSelector:@selector(__setTintColor:) fromSelector:@selector(setTintColor:)];

        if (![UIDevice currentDevice].iOS7) {
            [self copyToSelector:@selector(tintColor) fromSelector:@selector(___tintColor)];
            [self copyToSelector:@selector(setTintColor:) fromSelector:@selector(___setTintColor:)];
        }

        UI7ButtonDefaultTitleColor = [[UIColor colorWithRed:0.21960785f green:0.32941177f blue:0.52941180f alpha:1.0] retain];
    }
}

+ (void)patch {
    Class target = [UIButton class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [target classMethodObjectForSelector:@selector(buttonWithType:)].implementation = [self.class classMethodObjectForSelector:@selector(buttonWithType:)].implementation;
    [self exportSelector:@selector(setTitleColor:forState:) toClass:target];
    [self exportSelector:@selector(drawRect:) toClass:target];
    [NSClassFromString(@"UIRoundedRectButton") addMethodForSelector:@selector(initWithCoder:) fromMethod:[self methodObjectForSelector:@selector(_UIRoundedRectButton_initWithCoder:)]];

    if (![UIDevice currentDevice].iOS7) {
        [self exportSelector:@selector(tintColor) toClass:target];
        [self exportSelector:@selector(setTintColor:) toClass:target];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        UIColor *color = [aDecoder decodeObjectForKey:@"UITintColor"];
        if (color) {
            self.tintColor = color;
        }
        NSDictionary *statefulContents = [aDecoder decodeObjectForKey:@"UIButtonStatefulContent"];
        NSObject *normalStatefulContent = statefulContents[@0];
        if ([normalStatefulContent.titleColor isEqual:UI7ButtonDefaultTitleColor]) {
            [self setTitleColor:nil forState:UIControlStateNormal];
            self.___textTitleColor = nil;
        } else {
            self.___textTitleColor = [self titleColorForState:UIControlStateNormal];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self != nil) {
        [self _buttonInitTheme];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType {
    UIButton *button = nil;
    if (buttonType == UIButtonTypeRoundedRect) {
        button = [self __buttonWithType:UIButtonTypeCustom];
    } else {
        button = [self __buttonWithType:buttonType];
    }

    [button _buttonInitTheme];
    return button;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.___textTitleColor = color;
        [self _tintColorUpdated];
    }
}

- (UIColor *)___tintColor {
    UIColor *color = [self __tintColor];
    if (color) {
        return color;
    }
    return [self _tintColor];
}

- (void)___setTintColor:(UIColor *)tintColor {
    [self _setTintColor:tintColor];
}

@end


@implementation UI7RoundedRectButton

- (void)_roundedRectButtonInit {
    self.layer.cornerRadius = 6.0;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)_tintColorUpdated {
    UIColor *tintColor = self.tintColor;
    if (tintColor == nil) return;

    if (self.___backgroundColor == nil) {
        [self __setBackgroundColor:tintColor];
    } else {
        [self __setBackgroundColor:self.___backgroundColor];
    }
    UIColor *backgroundColor = self.superview.stackedBackgroundColor;
    [self __setTitleColor:backgroundColor forState:UIControlStateNormal];
    UIColor *highlightedTintColor = [tintColor highligtedColorForBackgroundColor:backgroundColor];
    [self __setTitleColor:highlightedTintColor forState:UIControlStateHighlighted];
    [self __setTitleColor:highlightedTintColor forState:UIControlStateSelected];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.___backgroundColor = [aDecoder decodeObjectForKey:@"UIBackgroundColor"];
    [self _roundedRectButtonInit];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self _roundedRectButtonInit];
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.___backgroundColor = backgroundColor;
    [self _tintColorUpdated];
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    [self _tintColorUpdated]; // for iOS6 SDK + iOS7
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    [self _tintColorUpdated]; // for iOS7
}

@end
