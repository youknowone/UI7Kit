//
//  UI7AlertView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <cdebug/debug.h>

#import "UI7Font.h"
#import "UI7Color.h"
#import "UI7Button.h"

#import "UI7AlertView.h"

const CGFloat UI7AlertViewWidth = 270.0f;

@interface UIAlertView (Private)

@property(nonatomic,readonly) UILabel *titleLabel;
@property(nonatomic,readonly) UILabel *bodyTextLabel;
@property(nonatomic,readonly) NSArray *buttons;
@property(nonatomic,readonly) UIView *_dimView __deprecated; // rejected
@property(nonatomic,assign) BOOL *dimsBackground __deprecated; // rejected

- (void)dismissWithClickedButtonIndex:(int)arg1 animated:(BOOL)arg2;

@end


static NSString *UI7AlertViewDimView = @"UI7AlertViewDimView";
static NSString *UI7AlertViewBackgroundView = @"UI7AlertViewBackgroundView";
static NSString *UI7AlertViewStrokeViews = @"UI7AlertViewStrokeViews";


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
    return [self associatedObjectForKey:UI7AlertViewDimView];
}

- (void)setDimView:(UIView *)dimView {
    [self setAssociatedObject:dimView forKey:UI7AlertViewDimView];
}

- (UIView *)backgroundView {
    return [self associatedObjectForKey:UI7AlertViewBackgroundView];
}

- (void)setBackgroundView:(UIView *)backgroundView {
    [self setAssociatedObject:backgroundView forKey:UI7AlertViewBackgroundView];
}

- (NSMutableArray *)strokeViews {
    return [self associatedObjectForKey:UI7AlertViewStrokeViews];
}

- (void)setStrokeViews:(NSMutableArray *)strokeViews {
    [self setAssociatedObject:strokeViews forKey:UI7AlertViewStrokeViews];
}

@end


@interface UIAlertButton: UIButton

@property(nonatomic,copy) NSString *title;

@end


@implementation UIAlertView (UI7AlertView)

- (void)relayout {
    // dim view - not available before setDimsBackground as NO
    UIView *view = self.dimView = [[[UIADimmingView alloc] initWithFrame:self.superview.bounds] autorelease];
    view.alpha = 0.4;
    view.hidden = YES;
    [view setHidden:NO animated:YES];
    [self.window insertSubview:view belowSubview:self];

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
        default: {
            if (self.message.length > 0) {
                baseHeight = self.bodyTextLabel.frame.origin.y + self.bodyTextLabel.frame.size.height;
            } else {
                baseHeight = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
            }
        }   break;
    }
    baseHeight += 14.5f;

    NSMutableArray *buttons = [[self.buttons mutableCopy] autorelease];
    UIButton *cancelButton = nil;
    if (self.cancelButtonIndex >= 0) {
        cancelButton = self.buttons[self.cancelButtonIndex];
        [buttons moveObjectAtIndex:self.cancelButtonIndex toIndex:buttons.count - 1];
    }

    NSInteger rows = 0;
    for (NSUInteger index = 0; index < buttons.count; index++) {
        UIButton *button = buttons[index];
        if (button == cancelButton) {
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
        rows += 1;
        frame.size.height = UI7ControlRowHeight - 0.5f;
        frame.origin.y = baseHeight + UI7ControlRowHeight * (rows - 1);
        button.frame = frame;

        CGFloat strokeWidth = [[UIScreen mainScreen] scale] != 1.0f ? 0.5f : 1.0f;
        CGRect sframe;
        if (frame.origin.x < frame.size.width) {
            sframe = CGRectMake(7.0, frame.origin.y, UI7AlertViewWidth, strokeWidth);
        } else {
            sframe = CGRectMake(142.0, frame.origin.y, strokeWidth, UI7ControlRowHeight);
            rows -= 1;
        }
        UIView *strokeView = [[[UIView alloc] initWithFrame:sframe] autorelease];
        strokeView.backgroundColor = [UIColor colorWith8bitWhite:182 alpha:255];
        [self addSubview:strokeView];
        [self.strokeViews addObject:strokeView];
    }

    CGRect lastButtonFrame = [buttons.lastObject frame];

    // background image
    self.backgroundView.frame = CGRectMake(7.0, .0, UI7AlertViewWidth, lastButtonFrame.origin.y + lastButtonFrame.size.height);
    self.backgroundView.image = [UIImage roundedImageWithSize:self.backgroundView.frame.size color:[UI7Color defaultBarColor] radius:6.0];
}

@end


@implementation UIAlertView (Patch)

- (id)init { return [super init]; }
- (id)__init { assert(NO); return nil; }
- (void)__show { assert(NO); }
- (void)__dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated { assert(NO); }

@end


@implementation UI7AlertView

+ (void)initialize {
    if (self == [UI7AlertView class]) {
        Class target = [UIAlertView class];

        [target copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [target copyToSelector:@selector(__show) fromSelector:@selector(show)];
        [target copyToSelector:@selector(__dismissWithClickedButtonIndex:animated:) fromSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    }
}

+ (void)patch {
    Class target = [UIAlertView class];

    [self exportSelector:@selector(init) toClass:target];
    [self exportSelector:@selector(show) toClass:target];
    [self exportSelector:@selector(dismissWithClickedButtonIndex:animated:) toClass:target];
}

- (id)init {
    self = [self __init];
    if (self != nil) {
        SEL setDimsBackground = NSSelectorFromString([@"set" stringByAppendingString:@"DimsBackground:"]);
        [self performSelector:setDimsBackground withObject:(id)NO];
        self.backgroundImageView = [UIImage clearImage].view;
        self.backgroundView = [[[UIImageView alloc] init] autorelease];
        [self addSubview:self.backgroundView];
    }
    return self;
}


- (void)show {
    [self __show];

    [self relayout];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self __dismissWithClickedButtonIndex:buttonIndex animated:animated];
    [self.dimView setHidden:YES animated:animated];
}

@end
