//
//  UI7ViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7NavigationBar.h"
#import "UI7BarButtonItem.h"

#import "UI7ViewController.h"

static NSMutableDictionary *UI7ViewControllerNavigationItems = nil;
static NSMutableDictionary *UI7ViewControllerEditButtonItems = nil;

@interface UIViewController (Private)

- (void)_toggleEditing:(id)sender __deprecated; // rejected

@end


@implementation UIViewController (Patch)

- (id)__initViewControllerWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil { assert(NO); return nil; }
- (id)__initViewControllerWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__deallocViewController { assert(NO); }

- (void)_dealloc {
    [UI7ViewControllerNavigationItems removeObjectForKey:self.pointerString];
    [UI7ViewControllerEditButtonItems removeObjectForKey:self.pointerString];
    [self __deallocViewController];
}

- (void)_viewControllerInit {
    
}

@end


@interface UI7ViewController ()

@end

@implementation UI7ViewController

+ (void)initialize {
    if (self == [UI7ViewController class]) {
        UI7ViewControllerNavigationItems = [[NSMutableDictionary alloc] init];
        UI7ViewControllerEditButtonItems = [[NSMutableDictionary alloc] init];

        Class origin = [UIViewController class];

        [origin copyToSelector:@selector(__initViewControllerWithCoder:) fromSelector:@selector(initWithCoder:)];
        [origin copyToSelector:@selector(__initViewControllerWithNibName:bundle:) fromSelector:@selector(initWithNibName:bundle:)];
        [origin copyToSelector:@selector(__deallocViewController) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UIViewController class];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(initWithNibName:bundle:) toClass:target];
    [source copyToSelector:@selector(dealloc) fromSelector:@selector(_dealloc)];
}

- (void)dealloc {
    [super _dealloc];
    return;
    [super dealloc];
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
    UI7NavigationItem *item = UI7ViewControllerNavigationItems[self.pointerString];
    if (item == nil) {
        item = [[[UI7NavigationItem alloc] initWithTitle:self.title] autorelease];
        UI7ViewControllerNavigationItems[self.pointerString] = item;
    }
    return item;
}

- (UIBarButtonItem *)editButtonItem {
    UI7BarButtonItem *item = UI7ViewControllerEditButtonItems[self.pointerString];
    if (item == nil) {
        item = [[[UI7BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_toggleEditing:)] autorelease];
        UI7ViewControllerEditButtonItems[self.pointerString] = item;
    }
    return item;
}

@end


@implementation UI7TableViewController

// Dynamic patch is not required

+ (void)initialize {
    if (self == [UI7TableViewController class]) {
        Class source = [UI7ViewController class];
        Class target = [UI7TableViewController class];

        [source exportSelector:@selector(navigationItem) toClass:target];
        [source exportSelector:@selector(editButtonItem) toClass:target];
        [source exportSelector:@selector(setTitle:) toClass:target];
    }
}

@end
