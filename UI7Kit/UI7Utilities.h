//
//  UI7Utilities.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UIKitExtension/UIKitExtension.h>
#import <UI7Kit/UI7KitCore.h>

#import <UI7Kit/UI7Color.h>

@interface UIDevice (iOS7)

@property(nonatomic, readonly) NSInteger majorVersion;
@property(nonatomic, readonly, getter=isIOS7) BOOL iOS7;
@property(nonatomic, readonly) BOOL needsUI7Kit;

@end


@interface NSObject (MethodCopying)

+ (void)copyToSelector:(SEL)toSelector fromSelector:(SEL)fromSelector;
+ (void)exportSelector:(SEL)selector toClass:(Class)toClass;

@end


UIKIT_EXTERN const CGFloat UI7ControlRadius;
UIKIT_EXTERN const CGSize UI7ControlRadiusSize;
UIKIT_EXTERN const CGFloat UI7ControlRowHeight;

@interface UIImage (Images)

- (UIImageView *)view;

+ (UIImage *)roundedImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius;

@end

