//
//  UI7ActivityViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 21..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import <cdebug/debug.h>
#import <UI7Kit/UI7Utilities.h>
#import <UI7Kit/UI7Font.h>

#import "UI7ActivityViewController.h"

@interface UIActivityListView : UIView

@property(retain) UIImageView *backgroundView;
@property(retain) UIButton * cancelButton;
@property(retain) UIScrollView * scrollView;

@end


@interface UIActivityViewController (Private)

@property(retain) UIViewController * activityListViewController; // UIActivityListViewController

@end


@implementation UIActivityViewController (Patch)

- (void)___viewWillAppear:(BOOL)animated { dassert(NO); }

@end


@implementation UI7ActivityViewController

+ (void)initialize {
    if (self == [UI7ActivityViewController class]) {
        Class target = [UIActivityViewController class];

        [target addMethodForSelector:@selector(viewWillAppear:) fromMethod:[self methodObjectForSelector:@selector(viewWillAppear:)]]; // fill if empty
        [target copyToSelector:@selector(___viewWillAppear:) fromSelector:@selector(viewWillAppear:)];
    }
}

+ (void)patch {
    Class target = [UIActivityViewController class];

    [self exportSelector:@selector(viewWillAppear:) toClass:target];
}

- (void)viewWillAppear:(BOOL)animated {
    [self ___viewWillAppear:animated];
    UIActivityListView *listView = (id)self.activityListViewController.view;
    listView.backgroundView.image = [UIColor whiteColor].image;
    if (listView.cancelButton) {
        listView.cancelButton.backgroundColor = nil;
        listView.cancelButton.titleLabel.shadowOffset = CGSizeZero;
        [listView.cancelButton setImage:nil forState:UIControlStateNormal];
        listView.cancelButton.titleLabel.font = [UI7Font systemFontOfSize:24.0f attribute:UI7FontAttributeLight];
    }
    for (UIButton *button in listView.scrollView.subviews) { // UIActivityButton
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.shadowOffset = CGSizeZero;
        button.titleLabel.font = [UI7Font systemFontOfSize:11.0f attribute:UI7FontAttributeLight];
    }
}

@end
