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
        NSAClass *class = [NSAClass classWithClass:[UINavigationController class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithRootViewController:) fromSelector:@selector(initWithRootViewController:)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];
    Class targetClass = [UINavigationController class];

    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass];
    [sourceClass exportSelector:@selector(initWithRootViewController:) toClass:targetClass];
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
