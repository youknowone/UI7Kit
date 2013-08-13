//
//  UITIssue71ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 13..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITIssue71ViewController.h"

@interface UITIssue71ViewController ()

@end

@implementation UITIssue71ViewController

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

- (void)viewDidAppear:(BOOL)animated {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = true;
    imagePickerController.mediaTypes = @[@"public.image"];
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
