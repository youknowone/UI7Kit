//
//  UITExternalViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 21..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITExternalViewController.h"

@interface UITTestActivity : UIActivity

@end


@implementation UITTestActivity

- (NSString *)activityType {
    return @"test";
}

- (NSString *)activityTitle {
    return @"Test Activity";
}

- (UIImage *)activityImage {
    return [UIColor redColor].image;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

@end


@interface UITExternalViewController ()

@end

@implementation UITExternalViewController

@synthesize popoverController=__popoverController;

- (void)showImagePicker:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = true;
    imagePickerController.mediaTypes = @[@"public.image"];
    imagePickerController.delegate = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentModalViewController:imagePickerController animated:true];
    } else {
        UIPopoverController *controller = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        [controller presentPopoverFromRect:CGRectMake(.0f, .0f, 300.0f, 600.0f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    NSArray *applicationActivities = @[[[UITTestActivity alloc] init]];

    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"activity"] applicationActivities:applicationActivities];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityViewController animated:YES completion:NULL];
    } else {
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [self.popoverController presentPopoverFromRect:CGRectMake(.0, .0, 300, 600)
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
}


@end
