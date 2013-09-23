//
//  UI7Font.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 22..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Utilities.h>

UIKIT_EXTERN NSString *const UI7FontTextStyleHeadline;
UIKIT_EXTERN NSString *const UI7FontTextStyleSubheadline;
UIKIT_EXTERN NSString *const UI7FontTextStyleBody;
UIKIT_EXTERN NSString *const UI7FontTextStyleFootnote;
UIKIT_EXTERN NSString *const UI7FontTextStyleCaption1;
UIKIT_EXTERN NSString *const UI7FontTextStyleCaption2;


#define UIFontTextStyleHeadline UI7FontTextStyleHeadline
#define UIFontTextStyleSubheadline UI7FontTextStyleSubheadline
#define UIFontTextStyleBody UI7FontTextStyleBody
#define UIFontTextStyleFootnote UI7FontTextStyleFootnote
#define UIFontTextStyleCaption1 UI7FontTextStyleCaption1
#define UIFontTextStyleCaption2 UI7FontTextStyleCaption2

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@interface UIFont (iOS7)

//* 
+ (UIFont *)preferredFontForTextStyle:(NSString *)style;

@end
#endif

UIKIT_EXTERN NSString *const UI7FontAttributeNone;
UIKIT_EXTERN NSString *const UI7FontAttributeUltraLight;
UIKIT_EXTERN NSString *const UI7FontAttributeUltraLightItalic;
UIKIT_EXTERN NSString *const UI7FontAttributeLight;
UIKIT_EXTERN NSString *const UI7FontAttributeLightItalic;
UIKIT_EXTERN NSString *const UI7FontAttributeMedium;
UIKIT_EXTERN NSString *const UI7FontAttributeItalic;
UIKIT_EXTERN NSString *const UI7FontAttributeBold;
UIKIT_EXTERN NSString *const UI7FontAttributeBoldItalic;
UIKIT_EXTERN NSString *const UI7FontAttributeCondensedBold;
UIKIT_EXTERN NSString *const UI7FontAttributeCondensedBlack;


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

@interface UIFont (UI7Kit)

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

