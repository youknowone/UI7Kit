//
//  UI7Font.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 22..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Utilities.h>

UIKIT_EXTERN NSString *UI7FontAttributeNone;
UIKIT_EXTERN NSString *UI7FontAttributeUltraLight;
UIKIT_EXTERN NSString *UI7FontAttributeUltraLightItalic;
UIKIT_EXTERN NSString *UI7FontAttributeLight;
UIKIT_EXTERN NSString *UI7FontAttributeLightItalic;
UIKIT_EXTERN NSString *UI7FontAttributeMedium;
UIKIT_EXTERN NSString *UI7FontAttributeItalic;
UIKIT_EXTERN NSString *UI7FontAttributeBold;
UIKIT_EXTERN NSString *UI7FontAttributeBoldItalic;
UIKIT_EXTERN NSString *UI7FontAttributeCondensedBold;
UIKIT_EXTERN NSString *UI7FontAttributeCondensedBlack;

@interface UI7Font : UIFont<UI7Patch>

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)italicSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)systemFontOfSize:(CGFloat)fontSize attribute:(NSString *)attribute;

@end

//! @deprecated Use UI7FontAttributeLight
UIKIT_EXTERN NSString *UI7FontWeightLight __deprecated;
//! @deprecated Use UI7FontAttributeMedium
UIKIT_EXTERN NSString *UI7FontWeightMedium __deprecated;
//! @deprecated Use UI7FontAttributeBold
UIKIT_EXTERN NSString *UI7FontWeightBold __deprecated;

@interface UIFont (iOS7)

+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize attribute:(NSString *)attribute;

/*!
 *  @deprecated Use UI7Font::systemFontOfSize:
 */
+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize __deprecated;
/*!
 *  @deprecated Use UI7Font::systemFontOfSize:attribute:
 */
+ (UIFont *)iOS7SystemFontOfSize:(CGFloat)fontSize weight:(NSString *)weight __deprecated;

@end

