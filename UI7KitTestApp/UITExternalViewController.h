//
//  UITExternalViewController.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 21..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>

@interface UITExternalViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property(nonatomic,strong) UIPopoverController *popoverController;

- (IBAction)showImagePicker:(id)sender;
- (IBAction)showMailComposer:(id)sender;
- (IBAction)showAddressBook:(id)sender;
- (IBAction)showActivityController:(id)sender;

@end
