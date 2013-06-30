//
//  UI7AlertView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"
#import "UI7Color.h"
#import "UI7Button.h"

#import "UI7AlertView.h"

@interface UIAlertView (Private)

@property(nonatomic,readonly) UILabel *titleLabel;
@property(nonatomic,readonly) UILabel *bodyTextLabel;
@property(nonatomic,readonly) NSArray *buttons;
@property(nonatomic,readonly) UIView *_dimView __deprecated; // rejected
@property(nonatomic,assign) BOOL *dimsBackground __deprecated; // rejected

- (void)dismissWithClickedButtonIndex:(int)arg1 animated:(BOOL)arg2;

@end


static NSMutableDictionary *UI7AlertViewDimViews = nil;
static NSMutableDictionary *UI7AlertViewBackgroundViews = nil;
static NSMutableDictionary *UI7AlertViewStrokeViews = nil;


@interface UIAlertView (Accessor)

@property(nonatomic,retain) UIView *backgroundImageView;

@property(nonatomic,retain) UIView *dimView;
@property(nonatomic,assign) UIImageView *backgroundView;
@property(nonatomic,assign) NSMutableArray *strokeViews;

@end


@implementation UIAlertView (Accessor)

NSAPropertyGetter(backgroundImageView, @"_backgroundImageView")
NSAPropertyRetainSetter(setBackgroundImageView, @"_backgroundImageView")

- (UIView *)dimView {
    return UI7AlertViewDimViews[self.pointerString];
}

- (void)setDimView:(UIView *)dimView {
    UI7AlertViewDimViews[self.pointerString] = dimView;
}

- (UIView *)backgroundView {
    return UI7AlertViewBackgroundViews[self.pointerString];
}

- (void)setBackgroundView:(UIView *)backgroundView {
    UI7AlertViewBackgroundViews[self.pointerString] = backgroundView;
}

- (NSMutableArray *)strokeViews {
    return UI7AlertViewStrokeViews[self.pointerString];
}

- (void)setStrokeViews:(NSMutableArray *)strokeViews {
    UI7AlertViewStrokeViews[self.pointerString] = strokeViews;
}

@end


@interface UIAlertButton: UIButton

@property(nonatomic,copy) NSString *title;

@end


@interface UI7AlertView ()


@end


@implementation UIAlertView (Patch)

- (id)init { return [super init]; }
- (id)__init { assert(NO); return nil; }
- (void)__show { assert(NO); }
- (void)__dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated { assert(NO); }

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    [UI7AlertViewDimViews removeObjectForKey:self.pointerString];
    [UI7AlertViewBackgroundViews removeObjectForKey:self.pointerString];
    [UI7AlertViewStrokeViews removeObjectForKey:self.pointerString];
    [self __dealloc];
}

@end


@implementation UI7AlertView

+ (void)initialize {
    if (self == [UI7AlertView class]) {
        UI7AlertViewDimViews = [[NSMutableDictionary alloc] init];
        UI7AlertViewBackgroundViews = [[NSMutableDictionary alloc] init];
        UI7AlertViewStrokeViews = [[NSMutableDictionary alloc] init];

        Class target = [UIAlertView class];

        [target copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [target copyToSelector:@selector(__show) fromSelector:@selector(show)];
        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
        [target copyToSelector:@selector(__dismissWithClickedButtonIndex:animated:) fromSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    }
}

+ (void)patch {
    Class target = [UIAlertView class];

    [self exportSelector:@selector(init) toClass:target];
    [self exportSelector:@selector(show) toClass:target];
    [self exportSelector:@selector(dealloc) toClass:target];
    [self exportSelector:@selector(dismissWithClickedButtonIndex:animated:) toClass:target];
}

- (void)dealloc {
    [super _dealloc];
    return;
    [super dealloc];
}

- (id)init {
    self = [self __init];
    if (self != nil) {
//        self.dimsBackground = NO; // need better
        self.backgroundImageView = [UIImage clearImage].view;
        self.backgroundView = [[[UIImageView alloc] init] autorelease];
        [self addSubview:self.backgroundView];
    }
    return self;
}

- (void)show {
    [self __show];;

    // dim view - not available before setDimsBackground as NO
//    UIView *view = self.dimView = [[[UIADimmingView alloc] initWithFrame:self.superview.bounds] autorelease];
//    view.alpha = 0.4;
//    view.hidden = YES;
//    [view setHidden:NO animated:YES];
//    [self.window insertSubview:view belowSubview:self];

    // common UI attributes
    self.titleLabel.textColor = self.bodyTextLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = self.bodyTextLabel.shadowOffset = CGSizeZero;

    self.titleLabel.font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeMedium];
    self.bodyTextLabel.font = [UI7Font systemFontOfSize:15.0 attribute:UI7FontAttributeLight];

    // reset strokes
    for (UIView *strokeView in self.strokeViews) {
        [strokeView removeFromSuperview];
    }
    self.strokeViews = [NSMutableArray array];

    // button UI

    CGFloat baseHeight = .0;
    switch (self.alertViewStyle) {
        case UIAlertViewStylePlainTextInput:
        case UIAlertViewStyleSecureTextInput: {
            UITextField *field = [self textFieldAtIndex:0];
            baseHeight = field.frame.origin.y + field.frame.size.height;
        }   break;
        case UIAlertViewStyleLoginAndPasswordInput: {
            UITextField *field = [self textFieldAtIndex:1];
            baseHeight = field.frame.origin.y + field.frame.size.height;
        }   break;
       case UIAlertViewStyleDefault:
      default:{
            if (self.message.length>0) {
            baseHeight = self.bodyTextLabel.frame.origin.y + self.bodyTextLabel.frame.size.height;
            }else{
            baseHeight = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
            }
            break;
        }
    }
    baseHeight += 14.5f;

    NSInteger rows = 0;
    for (NSUInteger index = 0; index < self.buttons.count; index++) {
        UIButton *button = self.buttons[index];
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UI7Font systemFontOfSize:16.0 attribute:UI7FontAttributeMedium];
        } else {
            button.titleLabel.font = [UI7Font systemFontOfSize:16.0 attribute:UI7FontAttributeLight];
        }
        [button setTitleColor:[UI7Color defaultTintColor] forState:UIControlStateNormal];
        [button setTitleColor:[UI7Color defaultTintColor].highligtedColor forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        [button setBackgroundImage:nil forState:UIControlStateDisabled];

        CGRect frame = button.frame;
        if (frame.origin.x < frame.size.width) {
            rows += 1;
        }
        frame.size.height = 43.5f;
        frame.origin.y = baseHeight + 44.0f * (rows - 1);
        button.frame = frame;

        frame.size.height = 0.5f;
        CGRect sframe;
        if (frame.origin.x < frame.size.width) {
            sframe = CGRectMake(7.0, frame.origin.y, 270.0, 0.5);
        } else {
            sframe = CGRectMake(142.0, frame.origin.y, 0.5, 44.0);
        }
        UIView *strokeView = [[[UIView alloc] initWithFrame:sframe] autorelease];
        strokeView.backgroundColor = [UIColor colorWith8bitWhite:182 alpha:255];
        [self addSubview:strokeView];
        [self.strokeViews addObject:strokeView];
    }

    CGRect lastButtonFrame = [self.buttons.lastObject frame];

    // background image
    self.backgroundView.frame = CGRectMake(7.0, .0, 270.0, lastButtonFrame.origin.y + lastButtonFrame.size.height);
    self.backgroundView.image = [UIImage roundedImageWithSize:self.backgroundView.frame.size color:[UIColor colorWith8bitWhite:234 alpha:248] radius:UI7ControlRadius];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self __dismissWithClickedButtonIndex:buttonIndex animated:animated];
    if (animated) {
        [self.dimView setHidden:YES animated:YES];
    }
}

@end
