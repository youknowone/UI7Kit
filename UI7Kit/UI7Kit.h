//
//  UI7Kit.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

/*!
 *      #import <UI7Kit/UI7Kit.h>
 *      [UI7Kit patchIfNeeded]; // in main.m, before UIApplicationMain()
 */

#if __has_include(<UI7Kit/UI7Button.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif
#if __has_include(<UI7Kit/UI7PickerView.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif
#if __has_include(<UI7Kit/UI7SearchBar.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif
#if __has_include(<UI7Kit/UI7SegmentedControl.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif
#if __has_include(<UI7Kit/UI7Stepper.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif
#if __has_include(<UI7Kit/UI7TextField.h>)
#define UI7KIT_HAS_QUARTZCORE
#endif

#ifdef UI7KIT_HAS_QUARTZCORE
#import <QuartzCore/QuartzCore.h>
#endif

// Core
#import <UI7Kit/UI7KitCore.h>
#import <UI7Kit/UI7Utilities.h>

#ifdef COCOAPODS

#if __has_include(<UI7Kit/UI7Font.h>)
#import <UI7Kit/UI7Font.h>
#endif

#if __has_include(<UI7Kit/UI7AlertView.h>)
#import <UI7Kit/UI7AlertView.h>
#endif

#if __has_include(<UI7Kit/UI7ActionSheet.h>)
#import <UI7Kit/UI7ActionSheet.h>
#endif

#if __has_include(<UI7Kit/UI7BarButtonItem.h>)
#import <UI7Kit/UI7BarButtonItem.h>
#endif

#if __has_include(<UI7Kit/UI7Button.h>)
#import <UI7Kit/UI7Button.h>
#endif

#if __has_include(<UI7Kit/UI7NavigationBar.h>)
#import <UI7Kit/UI7NavigationBar.h>
#endif

#if __has_include(<UI7Kit/UI7NavigationController.h>)
#import <UI7Kit/UI7NavigationController.h>
#endif

#if __has_include(<UI7Kit/UI7ProgressView.h>)
#import <UI7Kit/UI7ProgressView.h>
#endif

#if __has_include(<UI7Kit/UI7PickerView.h>)
#import <UI7Kit/UI7PickerView.h>
#endif

#if __has_include(<UI7Kit/UI7SearchBar.h>)
#import <UI7Kit/UI7SearchBar.h>
#endif

#if __has_include(<UI7Kit/UI7SegmentedControl.h>)
#import <UI7Kit/UI7SegmentedControl.h>
#endif

#if __has_include(<UI7Kit/UI7Slider.h>)
#import <UI7Kit/UI7Slider.h>
#endif

#if __has_include(<UI7Kit/UI7Stepper.h>)
#import <UI7Kit/UI7Stepper.h>
#endif

#if __has_include(<UI7Kit/UI7TabBar.h>)
#import <UI7Kit/UI7TabBar.h>
#endif

#if __has_include(<UI7Kit/UI7TabBarItem.h>)
#import <UI7Kit/UI7TabBarItem.h>
#endif

#if __has_include(<UI7Kit/UI7TabBarController.h>)
#import <UI7Kit/UI7TabBarController.h>
#endif

#if __has_include(<UI7Kit/UI7TableView.h>)
#import <UI7Kit/UI7TableView.h>
#endif

#if __has_include(<UI7Kit/UI7TextField.h>)
#import <UI7Kit/UI7TextField.h>
#endif

#if __has_include(<UI7Kit/UI7Toolbar.h>)
#import <UI7Kit/UI7Toolbar.h>
#endif

#if __has_include(<UI7Kit/UI7View.h>)
#import <UI7Kit/UI7View.h>
#endif

#if __has_include(<UI7Kit/UI7ViewController.h>)
#import <UI7Kit/UI7ViewController.h>
#endif

#if __has_include(<UIKitExtension/UIKitExtension.h>)
#import <UIKitExtension/UIKitExtension.h>
#endif

#else // no cocoapods, so enable everything

#import <UI7Kit/UI7Font.h>
#import <UI7Kit/UI7AlertView.h>
#import <UI7Kit/UI7ActionSheet.h>
#import <UI7Kit/UI7BarButtonItem.h>
#import <UI7Kit/UI7Button.h>
#import <UI7Kit/UI7NavigationBar.h>
#import <UI7Kit/UI7NavigationController.h>
#import <UI7Kit/UI7ProgressView.h>
#import <UI7Kit/UI7PickerView.h>
#import <UI7Kit/UI7SearchBar.h>
#import <UI7Kit/UI7SegmentedControl.h>
#import <UI7Kit/UI7Slider.h>
#import <UI7Kit/UI7Stepper.h>
#import <UI7Kit/UI7TabBar.h>
#import <UI7Kit/UI7TabBarItem.h>
#import <UI7Kit/UI7TabBarController.h>
#import <UI7Kit/UI7TableView.h>
#import <UI7Kit/UI7TextField.h>
#import <UI7Kit/UI7Toolbar.h>
#import <UI7Kit/UI7View.h>
#import <UI7Kit/UI7ViewController.h>
#import <UIKitExtension/UIKitExtension.h>

#endif // ifdef COCOAPODS
