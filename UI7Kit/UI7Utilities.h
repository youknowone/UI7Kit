//
//  UI7Utilities.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>
#import <UI7Kit/UI7KitCore.h>


@interface UIDevice (iOS7)

@property(nonatomic, readonly) BOOL needsUI7Kit;

@end


@interface NSObject (Pointer)

@property(nonatomic, readonly) NSString *pointerString;

@end


@interface NSObject (MethodCopying)

+ (void)copyToSelector:(SEL)toSelector fromSelector:(SEL)fromSelector;
+ (void)exportSelector:(SEL)selector toClass:(Class)toClass;

@end


@interface UIColor (iOS7)

+ (UIColor *)iOS7BackgroundColor;
+ (UIColor *)iOS7ButtonTitleColor;
+ (UIColor *)iOS7ButtonTitleEmphasizedColor;

- (UIColor *)highligtedColor;

@end

UIKIT_EXTERN const CGFloat UI7ControlRadius;

@interface UIImage (Images)

- (UIImageView *)view;

+ (UIImage *)roundedImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius;

@end

