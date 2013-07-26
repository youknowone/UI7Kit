//
//  UI7BarButtonItem.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7Utilities.h"
#import "UI7Font.h"

#import "UI7BarButtonItem.h"


UIImage *UI7BarButtonItemImages[30] = { nil, };

@interface UIBarButtonItem (Private)

@property(nonatomic,readonly) BOOL isSystemItem;
@property(nonatomic,readonly) UIBarButtonSystemItem systemItem;

@end


@implementation UIBarButtonItem (Patch)

// backup
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action { assert(NO); return nil; }
- (id)__initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action { assert(NO); return nil; }
- (UIColor *)__tintColor { assert(NO); return nil; }
- (id)superview { return nil; }

- (void)_barButtonItemInitWithFont:(UIFont *)font {
    [self setBackgroundImage:[UIImage clearImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    /*  FIXME:
     *  Actually, iOS7 back button is not implemented in this way. There is new property about '<' mark.
     *  To implement this in right way, UINavigationBar -drawRect: should be rewritten entirely, in my guess.
     */
    UIImage *backImage = [UIImage imageNamed:@"UI7NavigationBarBackButton"];
    backImage = [backImage imageByFilledWithColor:self.tintColor];
    [self setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault]; // @2x is not retina image
    backImage = [backImage imageByFilledWithColor:self.tintColor.highligtedColor];
    [self setBackButtonBackgroundImage:backImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor:self.tintColor ?: [UI7Color defaultTintColor],
 UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
     }
                        forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor:self.tintColor.highligtedColor ?: [UI7Color defaultTintColor].highligtedColor,
 UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
     }
                        forState:UIControlStateHighlighted];
}

- (void)_barButtonItemInit {
    [self _barButtonItemInitWithFont:[UI7Font systemFontOfSize:17.0 attribute:self.style == UIBarButtonItemStyleDone ? UI7FontAttributeMedium : UI7FontAttributeLight]];
}

@end


@interface UI7BarButtonItem (Dynamic)

- (UIColor *)_tintColor;

@end


@implementation UI7BarButtonItem

+ (void)initialize {
    if (self == [UI7BarButtonItem class]) {
        Class target = [UIBarButtonItem class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithTitle:style:target:action:) fromSelector:@selector(initWithTitle:style:target:action:)];
        [target copyToSelector:@selector(__initWithBarButtonSystemItem:target:action:) fromSelector:@selector(initWithBarButtonSystemItem:target:action:)];
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
        [[UIView class] exportSelector:@selector(_tintColor) toClass:target];
    }
}

+ (void)patch {
    Class target =  [UIBarButtonItem class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithBarButtonSystemItem:target:action:) toClass:target];
    [self exportSelector:@selector(initWithTitle:style:target:action:) toClass:target];
    [[UIView class] exportSelector:@selector(tintColor) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
//        NSLog(@"%d", self.style);
        if (self.isSystemItem && (self.systemItem == UIBarButtonSystemItemSave || self.systemItem == UIBarButtonSystemItemDone)) {
            self.style = UIBarButtonItemStyleDone;
        } else {
            self.style = UIBarButtonItemStylePlain;
        }
        // NOTE: I have no idea how to enable tintColor but disable glow effect.
        self.tintColor = [UI7Kit kit].tintColor;
        [self _barButtonItemInit];
//        [self _setImageHasEffects:NO];
//        [[self _toolbarButton] _showPressedIndicator:NO];
    }
    return self;
}

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action {
    UIFont *font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeLight];
    switch (systemItem) {
        case UIBarButtonSystemItemAdd: {
            self = [super initWithTitle:@"＋" style:UIBarButtonItemStylePlain target:target action:action];
            font = [UI7Font systemFontOfSize:22.0 attribute:UI7FontAttributeMedium];
        }   break;
        case UIBarButtonSystemItemCompose:
        case UIBarButtonSystemItemReply:
        case UIBarButtonSystemItemAction:
        case UIBarButtonSystemItemOrganize:
        case UIBarButtonSystemItemTrash:
            //TODO
        default: {
            self = [self __initWithBarButtonSystemItem:systemItem target:target action:action];
            if (systemItem == UIBarButtonSystemItemSave || systemItem == UIBarButtonSystemItemDone) {
                self.style = UIBarButtonItemStyleDone;
            }
        }
    }
    [self _barButtonItemInitWithFont:font];

    return self;
}

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    self = [self __initWithTitle:title style:style target:target action:action];
    [self _barButtonItemInit];
    return self;
}

- (UIColor *)tintColor {
    return [self _tintColor];
}

@end
