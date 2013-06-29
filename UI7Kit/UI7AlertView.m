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

        Class origin = [UIAlertView class];

        [origin copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [origin copyToSelector:@selector(__show) fromSelector:@selector(show)];
        [origin copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
        [origin copyToSelector:@selector(__dismissWithClickedButtonIndex:animated:) fromSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UIAlertView class];

    [source exportSelector:@selector(init) toClass:target];
    [source exportSelector:@selector(show) toClass:target];
    [source exportSelector:@selector(dealloc) toClass:target];
    [source exportSelector:@selector(dismissWithClickedButtonIndex:animated:) toClass:target];
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
    [super __show];;

    if (self.alertViewStyle == UIAlertViewStyleDefault) {
        if (self.buttons.count>2) {
            self.frame=CGRectMake(0, 0, self.frame.size.width, 71+self.buttons.count*43+(self.message.length==0?0:[self.subviews[2] frame].size.height));
            self.center = CGPointMake(self.window.bounds.size.width/2, self.window.bounds.size.height/2);
        }

        self.backgroundView.frame = CGRectMake(7.0, .0, 270.0, self.frame.size.height - 12.0);
        self.backgroundView.image = [UIImage roundedImageWithSize:self.backgroundView.frame.size color:[UIColor colorWith8bitWhite:234 alpha:248] radius:UI7ControlRadius];
        UIView *view = self.dimView = [[[UIADimmingView alloc] initWithFrame:self.superview.bounds] autorelease];
        view.alpha = 0.4;
        view.hidden = YES;
        [view setHidden:NO animated:YES];
        [self.window addSubview:view];
        [self.window bringSubviewToFront:self];

        self.titleLabel.textColor = self.bodyTextLabel.textColor = [UIColor blackColor];
        self.titleLabel.shadowOffset = self.bodyTextLabel.shadowOffset = CGSizeZero;

        self.titleLabel.font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeMedium];
        self.bodyTextLabel.font = [UI7Font systemFontOfSize:16.0 attribute:UI7FontAttributeLight];

        for (UIView *strokeView in self.strokeViews) {
            [strokeView removeFromSuperview];
        }

        self.strokeViews = [NSMutableArray array];

        for (int i=0; i<self.buttons.count; i++) {
            UIAlertButton *button = self.buttons[i];
            if (self.cancelButtonIndex == (NSInteger)i) {
                button.titleLabel.font = [UI7Font systemFontOfSize:16.0 attribute:UI7FontAttributeMedium];
            } else {
                button.titleLabel.font = [UI7Font systemFontOfSize:16.0 attribute:UI7FontAttributeLight];
            }
            [button setTitleColor:[UI7Color defaultTintColor] forState:UIControlStateNormal];
            [button setTitleColor:[UI7Color defaultTintColor].highligtedColor forState:UIControlStateHighlighted];
            button.titleLabel.shadowOffset = CGSizeZero;
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            [button setBackgroundImage:nil forState:UIControlStateHighlighted];

            CGRect frame = button.frame;
            CGFloat y=0.0;

            if (((i>=2)&&(self.buttons.count>2))) {
                y = [self.buttons[i-1] frame].origin.y+43;
            }else if ((i==1)&&(self.buttons.count>2)) {
                y = frame.origin.y;
            }else y = frame.origin.y + 16.0;

            frame.origin.y = y;
            button.frame = frame;


            if ((self.cancelButtonIndex!=i)) {
                UIView *strokeView = [[UIView alloc] initWithFrame:CGRectMake(7.0, button.frame.origin.y, 270.0, 0.5)];
                strokeView.backgroundColor = [UIColor colorWith8bitWhite:182 alpha:255];
                [self addSubview:strokeView];
                [self.strokeViews addObject:strokeView];
            }

        }

        UIAlertButton *button = self.buttons[0]; //cancel button

        CGRect frame = button.frame;
        frame.origin.y = self.buttons.count>2?[self.buttons.lastObject frame].origin.y+43:frame.origin.y;
        button.frame = frame;

        UIView *strokeView = [[UIView alloc] initWithFrame:CGRectMake(7.0, button.frame.origin.y, 270.0, 0.5)];
        strokeView.backgroundColor = [UIColor colorWith8bitWhite:182 alpha:255];
        [self addSubview:strokeView];
        [self.strokeViews addObject:strokeView];

        if (self.buttons.count==2) {
            UIView *strokeView = [[UIView alloc] initWithFrame:CGRectMake(142, frame.origin.y, 0.5, frame.size.height)];
            strokeView.backgroundColor = [UIColor colorWith8bitWhite:182 alpha:255];
            [self addSubview:strokeView];
            [self.strokeViews addObject:strokeView];
        }
    }
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self __dismissWithClickedButtonIndex:buttonIndex animated:animated];
    if (animated) {
        [self.dimView setHidden:YES animated:YES];
    }
}

@end
