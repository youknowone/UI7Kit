//
//  UI7NavigationController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7NavigationBar.h"
#import "UI7Toolbar.h"

#import "UI7NavigationController.h"


@interface UINavigationController (Accessor)

@property(nonatomic,assign) Class navigationBarClass;

@end


@implementation UINavigationController (Accessor)

NSAPropertyGetter(navigationBarClass, @"_navigationBarClass");
NSAPropertyAssignSetter(setNavigationBarClass, @"_navigationBarClass");

@end


@implementation UINavigationController (Patch)

- (id)__init { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithRootViewController:(UIViewController *)rootViewController { assert(NO); return nil; }

- (void)_navigationControllerInit {
    
}

@end


@interface UI7NavigationController ()

@end

@implementation UI7NavigationController

// TODO: Implement 'pushViewController' with new transition animation.

- (id)_MFMailComposeViewController_init {
    self = [self __init];
    [self.navigationBar setTitleTextAttributes:@{}];
    return self;
}

+ (void)initialize {
    if (self == [UI7NavigationController class]) {
        Class target = [UINavigationController class];

        [target copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithRootViewController:) fromSelector:@selector(initWithRootViewController:)];
    }
}

+ (void)patch {
    Class target = [UINavigationController class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithRootViewController:) toClass:target];

    Class MFMailComposeViewController = NSClassFromString(@"MFMailComposeViewController");
    if (MFMailComposeViewController) {
        [MFMailComposeViewController addMethodForSelector:@selector(__init) fromMethod:[MFMailComposeViewController methodForSelector:@selector(init)]];
        NSAMethod *method = [self methodForSelector:@selector(_MFMailComposeViewController_init)];
        [MFMailComposeViewController addMethodForSelector:@selector(init) fromMethod:method];
        [MFMailComposeViewController methodForSelector:@selector(init)].implementation = method.implementation;
    }
}

- (id)init {
    self = [self initWithNavigationBarClass:[UI7NavigationBar class] toolbarClass:[UI7Toolbar class]];
    if (self != nil) {
        [self _navigationControllerInit];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [self initWithNavigationBarClass:[UI7NavigationBar class] toolbarClass:[UI7Toolbar class]];
    if (self != nil) {
        self.viewControllers = @[rootViewController];
        [self _navigationControllerInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self.navigationBarClass = [UI7NavigationBar class];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // no idea yet
    self = [self __initWithCoder:aDecoder];
    if (self) {
        [self _navigationControllerInit];
    }
    return self;
}

//- (BOOL)isNavigationBarHidden {
//    return [super isNavigationBarHidden];
//}

@end
