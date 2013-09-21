//
//  UITExternalViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 21..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITExternalViewController.h"

@interface UITExternalViewController ()

@end

@implementation UITExternalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)showImagePicker:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = true;
    imagePickerController.mediaTypes = @[@"public.image"];
    imagePickerController.delegate = self;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverController *controller = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        [controller presentPopoverFromRect:CGRectMake(.0f, .0f, 300.0f, 600.0f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentModalViewController:imagePickerController animated:true];
    }
}

- (void)showMailComposer:(id)sender {
    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
    composeViewController.delegate = self;
    composeViewController.topViewController.title = @"Send mail";
    [composeViewController setSubject:@"Subject"];
    [self presentModalViewController:composeViewController animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)showAddressBook:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;

    [self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

- (void)showActivityController:(id)sender {
    
}


@end
