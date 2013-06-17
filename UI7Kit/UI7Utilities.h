//
//  UI7Utilities.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>

extern void UI7KitPatchAll(BOOL override7);


@interface UIDevice (iOS7)

@property(nonatomic, readonly) BOOL needsUI7Kit;

@end


@interface NSObject (Pointer)

@property(nonatomic, readonly) NSString *pointerString;

@end


@interface NSAClass (MethodCopying)

- (void)copyToSelector:(SEL)toSelector fromSelector:(SEL)fromSelector;
- (void)exportSelector:(SEL)selector toClass:(NSAClass *)toClass;

@end


@interface UIColor (iOS7)

+ (UIColor *)iOS7BackgroundColor;
+ (UIColor *)iOS7ButtonTitleColor;
+ (UIColor *)iOS7ButtonTitleHighlightedColor;
+ (UIColor *)iOS7ButtonTitleEmphasizedColor;
+ (UIColor *)iOS7ButtonTitleEmphasizedHighlightedColor;

@end


UIKIT_EXTERN NSString *UI7FontWeightLight;
UIKIT_EXTERN NSString *UI7FontWeightMedium;
UIKIT_EXTERN NSString *UI7FontWeightBold;

@interface UIFont (iOS7)

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize weight:(NSString *)weight;

@end

UIKIT_EXTERN const CGFloat UI7ControlRadius;

@interface UIImage (Images)

+ (UIImage *)blankImage;
- (UIImageView *)view;

+ (UIImage *)roundedImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius;
+ (UIImage *)roundedImageWithSize:(CGSize)size; // default buttoncolor + redius 6

@end


@protocol UI7Patch <NSObject>

+ (void)patch;

@end
