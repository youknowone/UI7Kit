//
//  UI7NavigationBar.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7BarButtonItem.h"

#import "UI7NavigationBar.h"

#define DEBUG_NAVIGATIONBAR NO


@interface UINavigationBar (Private)

- (void)pushNavigationItem:(UINavigationItem *)item;
- (id)currentBackButton; // return UINavigationItemButtonView

@end


@implementation UINavigationBar (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__pushNavigationItem:(UINavigationItem *)item { assert(NO); }

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
        [class copyToSelector:@selector(__pushNavigationItem:) fromSelector:@selector(pushNavigationItem:)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];
    Class targetClass = [UINavigationBar class];

    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass];
    [sourceClass exportSelector:@selector(initWithFrame:) toClass:targetClass];
    [sourceClass exportSelector:@selector(pushNavigationItem:) toClass:targetClass];
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

//- (void)setItems:(NSArray *)items animated:(BOOL)animated {
//    [super setItems:items animated:animated];
//}
//
- (void)pushNavigationItem:(UINavigationItem *)item {
    [self __pushNavigationItem:item];
    dlog(DEBUG_NAVIGATIONBAR, @"pushNavigationItem: %@", self.backItem.backBarButtonItem);
    if (self.backItem.backBarButtonItem == nil) {
        self.backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:nil action:nil];  // this may cause problem if some code depends on existance of this value.
    }
}
//
//- (id)currentBackButton {
//    id button = [super currentBackButton];
//    dlog(DEBUG_NAVIGATIONBAR, @"ccurrentBackButton: %@ %@", button, [button title]);
//    return button;
//}


@end


@interface UI7NavigationItem (Patch)

@end


@implementation UI7NavigationItem

- (void)_navigationItemInit {
//    self.backBarButtonItem
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title];
    if (self != nil) {
        
    }
    return self;
}

//- (UIBarButtonItem *)backBarButtonItem {
//    UIBarButtonItem *item = [super backBarButtonItem];
//    return item;
//}
//
//- (void)setBackBarButtonItem:(UIBarButtonItem *)backBarButtonItem {
//    [super setBackBarButtonItem:backBarButtonItem];
//}

@end
