//
//  UI7AlertView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Button.h"

#import "UI7AlertView.h"

@interface UIAlertView (Private)

@property(nonatomic,readonly) UILabel *titleLabel;
@property(nonatomic,readonly) UILabel *bodyTextLabel;
@property(nonatomic,readonly) NSArray *buttons;
@property(nonatomic,retain,getter=_dimView) UIView *dimView;
@property(nonatomic,assign) BOOL *dimsBackground;

- (void)dismissWithClickedButtonIndex:(int)arg1 animated:(BOOL)arg2;

@end


static NSMutableDictionary *UI7AlertViewBackgroundViews = nil;
static NSMutableDictionary *UI7AlertViewStrokeViews = nil;


@interface UIAlertView (Accessor)

@property(nonatomic,retain) UIView *backgroundImageView;

@property(nonatomic,assign) UIImageView *backgroundView;
@property(nonatomic,assign) UIView *strokeView;

@end


@implementation UIAlertView (Accessor)

NSAPropertyGetter(backgroundImageView, @"_backgroundImageView")
NSAPropertyRetainSetter(setBackgroundImageView, @"_backgroundImageView")

- (UIView *)backgroundView {
    return UI7AlertViewBackgroundViews[self.pointerString];
}

- (void)setBackgroundView:(UIView *)backgroundView {
    UI7AlertViewBackgroundViews[self.pointerString] = backgroundView;
}

- (UIView *)strokeView {
    return UI7AlertViewStrokeViews[self.pointerString];
}

- (void)setStrokeView:(UIView *)strokeView {
    UI7AlertViewStrokeViews[self.pointerString] = strokeView;
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
    [UI7AlertViewBackgroundViews removeObjectForKey:self.pointerString];
    [UI7AlertViewStrokeViews removeObjectForKey:self.pointerString];
    [self __dealloc];
}

@end


@implementation UI7AlertView

+ (void)initialize {
    if (self == [UI7AlertView class]) {
        UI7AlertViewBackgroundViews = [[NSMutableDictionary alloc] init];
        UI7AlertViewStrokeViews = [[NSMutableDictionary alloc] init];

        NSAClass *origin = [UIAlertView classObject];

        [origin copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [origin copyToSelector:@selector(__show) fromSelector:@selector(show)];
        [origin copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
        [origin copyToSelector:@selector(__dismissWithClickedButtonIndex:animated:) fromSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    }
}

+ (void)patch {
    NSAClass *source = [self classObject];
    NSAClass *target = [UIAlertView classObject];

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
        self.dimsBackground = NO;
        self.backgroundImageView = [UIImage blankImage].view;
        self.backgroundView = [[[UIImageView alloc] init] autorelease];
        [self addSubview:self.backgroundView];

        self.strokeView = [[UIView alloc] initWithFrame:CGRectMake(7.0, .0, 270.0, 0.5)];
        self.strokeView.backgroundColor = [UIColor colorWith8BitWhite:182 alpha:255];
        [self addSubview:self.strokeView];
    }
    return self;
}

- (void)show {
    [super __show];
    self.backgroundView.frame = CGRectMake(7.0, .0, 270.0, self.frame.size.height - 12.0);
    self.backgroundView.image = [UIImage roundedImageWithSize:self.backgroundView.frame.size color:[UIColor colorWith8BitWhite:234 alpha:248] radius:6.0];
    UIView *view = self.dimView = [[[UIADimmingView alloc] initWithFrame:self.window.bounds] autorelease];
    view.alpha = 0.4;
    view.hidden = YES;
    [view setHidden:NO animated:YES];
    [self.window addSubview:view];
    [self.window bringSubviewToFront:self];


    self.titleLabel.textColor = self.bodyTextLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = self.bodyTextLabel.shadowOffset = CGSizeZero;

    self.titleLabel.font = [UIFont iOS7SystemFontOfSize:17.0 weight:UI7FontWeightMedium];
    self.bodyTextLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];

    CGFloat highest = self.frame.size.height;
    for (UIAlertButton *button in self.buttons) {
        button.titleLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];
        [button setTitleColor:[UIColor iOS7ButtonTitleColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor iOS7ButtonTitleHighlightedColor] forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];

        CGRect frame = button.frame;
        frame.origin.y += 16.0;
        button.frame = frame;

        highest = MIN(highest, button.frame.origin.y);
    }

    {
        CGRect frame = self.strokeView.frame;
        frame.origin.y = highest - 1.0f;
        self.strokeView.frame = frame;
    }
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self __dismissWithClickedButtonIndex:buttonIndex animated:animated];
    if (animated) {
        [self.dimView setHidden:YES animated:YES];
    }
}

@end
