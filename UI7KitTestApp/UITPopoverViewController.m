//
//  UITPopoverViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 6..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITPopoverViewController.h"
#import "UI7PopoverController.h"


@implementation UITPopoverViewController

@synthesize popoverController=__popoverController;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Popover"];
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];

    [self.popoverController presentPopoverFromRect:CGRectMake(.0, .0, 300, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end


@implementation UITPopoverContentViewController

- (void)actionSheet:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:@"button" otherButtonTitles:@"other", nil];
    [sheet showInView:self.view];
}

@end

