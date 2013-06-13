//
//  UI7NavigationBar.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7NavigationBar.h"

@implementation UINavigationBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_navigationBarInit {
    [self setBackgroundImage:[UIImage imageNamed:@"UI7NavigationBarPortrait"] forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[UIImage imageNamed:@"UI7NavigationBarLandscape"] forBarMetrics:UIBarMetricsLandscapePhone];
    [self setTitleTextAttributes:@{
                                   UITextAttributeFont: [UIFont iOS7SystemFontOfSize:17.0 weight:UI7FontWeightMedium],
                                   UITextAttributeTextColor: [UIColor blackColor],
                                   UITextAttributeTextShadowOffset: @(0),
                                   }];
}

@end


@implementation UI7NavigationBar

+ (void)initialize {
    if (self == [UI7NavigationBar class]) {
        NSAClass *class = [NSAClass classWithClass:[UINavigationBar class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];

    [sourceClass exportSelector:@selector(initWithCoder:) toClass:[UINavigationBar class]];
    [sourceClass exportSelector:@selector(initWithFrame:) toClass:[UINavigationBar class]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _navigationBarInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self) {
        [self _navigationBarInit];
    }
    return self;
}

@end


@implementation UI7NavigationItem


@end
