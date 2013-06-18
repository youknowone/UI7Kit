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

@implementation UINavigationController (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithRootViewController:(UIViewController *)rootViewController { assert(NO); return nil; }

- (void)_navigationControllerInit {
    
}

@end


@interface UI7NavigationController ()

@end

@implementation UI7NavigationController

// TODO: Implement 'pushViewController' with new transition animation.

+ (void)initialize {
    if (self == [UI7NavigationController class]) {
        Class origin = [UINavigationController class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initWithRootViewController:) fromSelector:@selector(initWithRootViewController:)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UINavigationController class];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(initWithRootViewController:) toClass:target];
}


- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [self initWithNavigationBarClass:[UI7NavigationBar class] toolbarClass:[UI7Toolbar class]];
    if (self != nil) {
        self.viewControllers = @[rootViewController];
        [self _navigationControllerInit];
    }
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
