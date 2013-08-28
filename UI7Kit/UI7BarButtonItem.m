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


NSString *UI7BarButtonItemSystemNames[] = {
    @"Done",
    @"Cancel",
    @"Edit",
    @"Save",
    @"Add",
    nil,
    nil,
    @"Compose",
    @"Reply",
    @"Action",
    @"Organize",
    @"Bookmarks",
    @"Search",
    @"Refresh",
    @"Stop",
    @"Camera",
    @"Trash",
    @"Play",
    @"Pause",
    @"Rewind",
    @"FastForward",
#if __IPHONE_3_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
    @"Undo",
    @"Redo",
#endif
#if __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
    @"PageCurl",
#endif
};

@implementation UIBarButtonItem (UI7BarButtonItem)

- (id)appearanceSuperview {
    return [self associatedObjectForKey:UI7AppearanceSuperview];
}

- (void)setAppearanceSuperview:(id)appearanceSuperview {
    [self setAssociatedObject:appearanceSuperview forKey:UI7AppearanceSuperview policy:OBJC_ASSOCIATION_ASSIGN];
}

- (void)_tintColorUpdated {
    UIFont *font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeLight];
    UIColor *tintColor = self.tintColor;
    if (tintColor == nil) return;
    /*  FIXME:
     *  Actually, iOS7 back button is not implemented in this way. There is new property about '<' mark.
     *  To implement this in right way, UINavigationBar -drawRect: should be rewritten entirely, in my guess.
     */
    UIImage *backImage = [UIImage imageNamed:@"UI7NavigationBarBackButton"];
    backImage = [backImage imageByFilledWithColor:tintColor];
    [self setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    backImage = [backImage imageByFilledWithColor:tintColor.highligtedColor];
    [self setBackButtonBackgroundImage:backImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor:tintColor,
 UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
     }
                        forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor:tintColor.highligtedColor,
 UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
     }
                        forState:UIControlStateHighlighted];
    self.image = [self.image imageByFilledWithColor:tintColor];
}

@end


@implementation UIBarButtonItem (Patch)

// backup
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action { assert(NO); return nil; }
- (id)__initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action { assert(NO); return nil; }
- (UIColor *)__tintColor { assert(NO); return nil; }

- (UIColor *)_tintColor {
    UIColor *color = [self __tintColor];
    if (color == nil) {
        color = [self.appearanceSuperview tintColor];
    }
    return color;
}

- (void)_barButtonItemInitWithFont:(UIFont *)font {
    [self setBackgroundImage:[UIImage clearImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    UIColor *tintColor = self.tintColor;
    if (tintColor == nil) return;
}

- (void)_barButtonItemInit {
    UIFont *font = [UI7Font systemFontOfSize:17.0 attribute:self.style == UIBarButtonItemStyleDone ? UI7FontAttributeMedium : UI7FontAttributeLight];
    [self _barButtonItemInitWithFont:font];
}


@end


@implementation UI7BarButtonItem

+ (void)initialize {
    if (self == [UI7BarButtonItem class]) {
        Class target = [UIBarButtonItem class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithTitle:style:target:action:) fromSelector:@selector(initWithTitle:style:target:action:)];
        [target copyToSelector:@selector(__initWithBarButtonSystemItem:target:action:) fromSelector:@selector(initWithBarButtonSystemItem:target:action:)];
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
    }
}

+ (void)patch {
    Class target =  [UIBarButtonItem class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithBarButtonSystemItem:target:action:) toClass:target];
    [self exportSelector:@selector(initWithTitle:style:target:action:) toClass:target];
    [self exportSelector:@selector(tintColor) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        if ([aDecoder containsValueForKey:@"UISystemItem"]) {
            UIBarButtonSystemItem item = [aDecoder decodeIntegerForKey:@"UISystemItem"];
            id new = [[self.class alloc] initWithBarButtonSystemItem:item target:self.target action:self.action];
            [self release];
            self = new;
        }
        [self _barButtonItemInit];
    }
    return self;
}

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action {
    UIFont *font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeLight];
    switch (systemItem) {
        case UIBarButtonSystemItemAdd:
        case UIBarButtonSystemItemCompose:
        case UIBarButtonSystemItemReply:
        case UIBarButtonSystemItemAction:
        case UIBarButtonSystemItemOrganize:
        case UIBarButtonSystemItemBookmarks:
        case UIBarButtonSystemItemSearch:
        case UIBarButtonSystemItemRefresh:
        case UIBarButtonSystemItemStop:
        case UIBarButtonSystemItemCamera:
        case UIBarButtonSystemItemTrash:
        case UIBarButtonSystemItemPlay:
        case UIBarButtonSystemItemPause:
        case UIBarButtonSystemItemRewind:
        case UIBarButtonSystemItemFastForward:
        {
            NSString *name = UI7BarButtonItemSystemNames[systemItem];
            UIImage *image = [UIImage imageNamed:[@"UI7BarButtonItemIcon%@" format:name]];
            self = [self initWithImage:image style:UIBarButtonItemStyleBordered target:target action:action];
        }   break;
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
    UIColor *color = [self _tintColor];
    return color;
}

@end
