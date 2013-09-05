//
//  UITPopoverViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 6..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITPopoverViewController.h"

@interface UITPopoverViewController ()

@end

@implementation UITPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Popover"];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];

    [popover presentPopoverFromRect:CGRectZero inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end


@implementation UITPopoverContentViewController

- (void)actionSheet:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:@"button" otherButtonTitles:@"other", nil];
    [sheet showInView:self.view];
}

@end

