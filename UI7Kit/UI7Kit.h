//
//  UIKit7.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

/*!
 *      #import <UI7Kit/UI7Kit.h>
 *      [UI7Kit patchIfNeeded]; // in main.m, before UIApplicationMain()
 */


#ifdef COCOAPODS
#include "../Pods-environment.h"
#else // no cocoapods, so enable everything

#define COCOAPODS_POD_AVAILABLE_FoundationExtension

#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ActionSheet
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7AlertView
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7BarButtonItem
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Button
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Color
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Font
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7NavigationBar
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7NavigationController
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7PickerView
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ProgressView
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7SearchBar
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7SegmentedControl
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Slider
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Stepper
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Switch
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBar
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBarController
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBarItem
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TableView
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TableViewCell
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TextField
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Toolbar
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7View
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ViewController
#define COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Window

#endif // ifdef COCOAPODS

#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Button
#define UI7KIT_HAS_QUARTZCORE
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7PickerView
#define UI7KIT_HAS_QUARTZCORE
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7SearchBar
#define UI7KIT_HAS_QUARTZCORE
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7SegmentedControl
#define UI7KIT_HAS_QUARTZCORE
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Stepper
#define UI7KIT_HAS_QUARTZCORE
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TextField
#define UI7KIT_HAS_QUARTZCORE
#endif

#ifdef UI7KIT_HAS_QUARTZCORE
#import <QuartzCore/QuartzCore.h>
#endif

#ifdef COCOAPODS_POD_AVAILABLE_FoundationExtension
#import <UIKitExtension/UIKitExtension.h>
#endif

// Core
#import <UI7Kit/UI7KitCore.h>
#import <UI7Kit/UI7Utilities.h>

#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Font
#import <UI7Kit/UI7Font.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7AlertView
#import <UI7Kit/UI7AlertView.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ActionSheet
#import <UI7Kit/UI7ActionSheet.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7BarButtonItem
#import <UI7Kit/UI7BarButtonItem.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Button
#import <UI7Kit/UI7Button.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7NavigationBar
#import <UI7Kit/UI7NavigationBar.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7NavigationController
#import <UI7Kit/UI7NavigationController.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ProgressView
#import <UI7Kit/UI7ProgressView.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7SegmentedControl
#import <UI7Kit/UI7SegmentedControl.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Slider
#import <UI7Kit/UI7Slider.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Stepper
#import <UI7Kit/UI7Stepper.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBarItem
#import <UI7Kit/UI7TabBar.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBar
#import <UI7Kit/UI7TabBarItem.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TabBarController
#import <UI7Kit/UI7TabBarController.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TableView
#import <UI7Kit/UI7TableView.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7TextField
#import <UI7Kit/UI7TextField.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7Toolbar
#import <UI7Kit/UI7Toolbar.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7View
#import <UI7Kit/UI7View.h>
#endif
#ifdef COCOAPODS_POD_AVAILABLE_UI7Kit_UI7ViewController
#import <UI7Kit/UI7ViewController.h>
#endif
