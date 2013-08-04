//
//  UI7View.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 19..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Utilities.h>

@interface UIView (iOS7)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
@property(nonatomic,strong) UIColor *tintColor;
- (void)tintColorDidChange;
#endif

@property(nonatomic,readonly) UIColor *stackedBackgroundColor;

@end


@interface UI7View: UIView<UI7Patch>

@end
