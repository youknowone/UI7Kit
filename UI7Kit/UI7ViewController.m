//
//  UI7ViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "NSArray.h"
#import "UIColor.h"

#import "UI7NavigationBar.h"
#import "UI7BarButtonItem.h"

#import "UI7ViewController.h"

static NSMutableDictionary *UI7ViewControllerNavigationItems = nil;
static NSMutableDictionary *UI7ViewControllerEditButtonItems = nil;

@interface UIViewController (Private)

- (void)_toggleEditing:(id)sender;

@end


@implementation UIViewController (Patch)

- (id)__initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__dealloc { assert(NO); }

- (void)_dealloc {
    [UI7ViewControllerNavigationItems removeObjectForKey:self.pointerString];
    [UI7ViewControllerEditButtonItems removeObjectForKey:self.pointerString];
    [super dealloc];
}

@end


@interface UI7ViewController ()

@end

@implementation UI7ViewController

+ (void)initialize {
    if (self == [UI7ViewController class]) {
        UI7ViewControllerNavigationItems = [[NSMutableDictionary alloc] init];
        UI7ViewControllerEditButtonItems = [[NSMutableDictionary alloc] init];
        NSAClass *class = [NSAClass classWithClass:[UIViewController class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithNibName:bundle:) fromSelector:@selector(initWithNibName:bundle:)];
        [class copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];
    Class targetClass = [UIViewController class];
    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass];
    [sourceClass exportSelector:@selector(initWithStyle:reuseIdentifier:) toClass:targetClass];
    [sourceClass copyToSelector:@selector(dealloc) fromSelector:@selector(_dealloc)];
}

- (void)dealloc {
    [super _dealloc];
    return;
    [super dealloc];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.navigationItem setTitle:title];
}

- (UINavigationItem *)navigationItem {
    UI7NavigationItem *item = [UI7ViewControllerNavigationItems objectForKey:self.pointerString];
    if (item == nil) {
        item = [[[UI7NavigationItem alloc] initWithTitle:self.title] autorelease];
        [UI7ViewControllerNavigationItems setObject:item forKey:self.pointerString];
    }
    return item;
}

- (UIBarButtonItem *)editButtonItem {
    UI7BarButtonItem *item = [UI7ViewControllerEditButtonItems objectForKey:self.pointerString];
    if (item == nil) {
        item = [[[UI7BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_toggleEditing:)] autorelease];
        [UI7ViewControllerEditButtonItems setObject:item forKey:self.pointerString];
    }
    return item;
}

@end
