//
//  UITPopoverViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 6..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITPopoverViewController.h"
#import "UI7PopoverController.h"

@interface UITPopoverViewController ()

@end

@implementation UITPopoverViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Popover"];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];

    [popover presentPopoverFromRect:CGRectMake(.0, .0, 300, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end


@implementation UITPopoverContentViewController

- (void)actionSheet:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:@"button" otherButtonTitles:@"other", nil];
    [sheet showInView:self.view];
}

@end

