//
//  UI7Button.h
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <UI7Kit/UI7Utilities.h>

#define UIButtonTypeSystem UIButtonTypeRoundedRect

@interface UI7Button : UIButton<UI7Patch>

@end


@interface UI7RoundedRectButton : UI7Button

@property(copy,nonatomic) NSNumber *cornerRadius;

@end


@interface UI7BorderedRoundedRectButton : UI7Button

@property(copy,nonatomic) NSNumber *cornerRadius;
@property(copy,nonatomic) NSNumber *borderWidth;

@end
