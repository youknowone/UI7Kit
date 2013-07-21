//
//  UI7ViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7NavigationBar.h"
#import "UI7BarButtonItem.h"

#import "UI7ViewController.h"

static NSString *UI7ViewControllerNavigationItem = @"UI7ViewControllerNavigationItem";
static NSString *UI7ViewControllerEditButtonItem = @"UI7ViewControllerEditButtonItem";

@interface UIViewController (Private)

- (void)_toggleEditing:(id)sender __deprecated; // rejected

@end


@implementation UIViewController (Patch)

- (id)__initViewControllerWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil { assert(NO); return nil; }
- (id)__initViewControllerWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_viewControllerInit {
    
}

@end


@interface UI7ViewController ()

@end

@implementation UI7ViewController

+ (void)initialize {
    if (self == [UI7ViewController class]) {
        Class target = [UIViewController class];

        [target copyToSelector:@selector(__initViewControllerWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initViewControllerWithNibName:bundle:) fromSelector:@selector(initWithNibName:bundle:)];
    }
}

+ (void)patch {
    Class target = [UIViewController class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithNibName:bundle:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initViewControllerWithCoder:aDecoder];
    if (self != nil) {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [self __initViewControllerWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {

    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.navigationItem setTitle:title];
}

- (UINavigationItem *)navigationItem {
    UI7NavigationItem *item = [self associatedObjectForKey:UI7ViewControllerNavigationItem];
    if (item == nil) {
        item = [[[UI7NavigationItem alloc] initWithTitle:self.title] autorelease];
        [self setAssociatedObject:item forKey:UI7ViewControllerNavigationItem];
    }
    return item;
}

- (UIBarButtonItem *)editButtonItem {
    UI7BarButtonItem *item = [self associatedObjectForKey:UI7ViewControllerEditButtonItem];
    if (item == nil) {
        SEL toggleSelector = NSSelectorFromString([@"_toggle" stringByAppendingString:@"Editing:"]);
        item = [[[UI7BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:toggleSelector] autorelease];
        [self setAssociatedObject:item forKey:UI7ViewControllerEditButtonItem];
    }
    return item;
}

@end
