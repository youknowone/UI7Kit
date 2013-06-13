//
//  UI7BarButtonItem.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UIColor.h"

#import "UI7Utilities.h"

#import "UI7BarButtonItem.h"


@implementation UIBarButtonItem (Patch)

// backup
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action { assert(NO); return nil; }
- (id)__initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action { assert(NO); return nil; }


- (void)_barButtonItemInitWithFont:(UIFont *)font {
    [self setBackgroundImage:[UIImage blankImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackButtonBackgroundImage:[UIImage blankImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor: [UIColor colorWithRed:.0 green:.5 blue:1.0 alpha:1.0],
 UITextAttributeTextShadowOffset: @(.0)
     }
                        forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{
             UITextAttributeFont:font,
        UITextAttributeTextColor: [UIColor colorWith8bitRed:197 green:221 blue:248 alpha:255],
 UITextAttributeTextShadowOffset: @(.0),
     }
                        forState:UIControlStateHighlighted];
}

- (void)_barButtonItemInit {
    [self _barButtonItemInitWithFont:[UIFont iOS7SystemFontOfSize:17.0 weight:UI7FontWeightLight]];
}

@end

@interface UI7BarButtonItem ()

@end


@implementation UI7BarButtonItem

+ (void)initialize {
    if (self == [UI7BarButtonItem class]) {
        NSAClass *class = [NSAClass classWithClass:[UIBarButtonItem class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithTitle:style:target:action:) fromSelector:@selector(initWithTitle:style:target:action:)];
        [class copyToSelector:@selector(__initWithBarButtonSystemItem:target:action:) fromSelector:@selector(initWithBarButtonSystemItem:target:action:)];
    }
}

+ (void)patch {
    NSAClass *class = [NSAClass classWithClass:self];
    Class toClass = [UIBarButtonItem class];
    [class exportSelector:@selector(initWithCoder:) toClass:toClass];
    [class exportSelector:@selector(initWithBarButtonSystemItem:target:action:) toClass:toClass];
    [class exportSelector:@selector(initWithTitle:style:target:action:) toClass:toClass];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    [self _barButtonItemInit];
    return self;
}

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action {
    UIFont *font = [UIFont iOS7SystemFontOfSize:17.0 weight:UI7FontWeightLight];
    switch (systemItem) {
        case UIBarButtonSystemItemAdd:
            self = [super initWithTitle:@"＋" style:UIBarButtonItemStylePlain target:target action:action];
            font = [UIFont iOS7SystemFontOfSize:22.0 weight:UI7FontWeightMedium];
            break;
        case UIBarButtonSystemItemCompose:
        case UIBarButtonSystemItemReply:
        case UIBarButtonSystemItemAction:
        case UIBarButtonSystemItemOrganize:
        case UIBarButtonSystemItemTrash:
            //TODO
            break;
        default:
            self = [self __initWithBarButtonSystemItem:systemItem target:target action:action];
    }
    [self _barButtonItemInitWithFont:font];
    return self;
}

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    self = [self __initWithTitle:title style:style target:target action:action];
    [self _barButtonItemInit];
    return self;
}

@end
