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

@end


static NSMutableDictionary *UI7AlertViewFrameViews = nil;
static NSMutableDictionary *UI7AlertViewStrokeViews = nil;


@interface UIAlertView (Accessor)

@property(nonatomic,retain) UIView *backgroundImageView;

@property(nonatomic,assign) UIView *frameView;
@property(nonatomic,assign) UIView *strokeView;

@end


@implementation UIAlertView (Accessor)

- (void)setBackgroundImageView:(UIView *)backgroundImageView {
    id view;
    [backgroundImageView retain];
    object_getInstanceVariable(self, "_backgroundImageView", (void **)&view);
    [view release];
    object_setInstanceVariable(self, "_backgroundImageView", backgroundImageView);
}

- (UIView *)backgroundImageView {
    void *view;
    object_getInstanceVariable(self, "_backgroundImageView", &view);
    return view;
}

- (UIView *)frameView {
    return [UI7AlertViewFrameViews :self.pointerString];
}

- (void)setFrameView:(UIView *)frameView {
    UI7AlertViewFrameViews[self.pointerString] = frameView;
}

- (UIView *)strokeView {
    return [UI7AlertViewStrokeViews :self.pointerString];
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

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    [UI7AlertViewFrameViews removeObjectForKey:self.pointerString];
    [UI7AlertViewStrokeViews removeObjectForKey:self.pointerString];
    [self __dealloc];
}

@end


@implementation UI7AlertView

+ (void)initialize {
    if (self == [UI7AlertView class]) {
        UI7AlertViewFrameViews = [[NSMutableDictionary alloc] init];
        UI7AlertViewStrokeViews = [[NSMutableDictionary alloc] init];

        NSAClass *origin = [UIAlertView classObject];
        [origin copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [origin copyToSelector:@selector(__show) fromSelector:@selector(show)];
        [origin copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    NSAClass *source = [self classObject];
    NSAClass *target = [UIAlertView classObject];

    [source exportSelector:@selector(init) toClass:target];
    [source exportSelector:@selector(show) toClass:target];
    [source exportSelector:@selector(dealloc) toClass:target];
}

- (void)dealloc {
    [super _dealloc];
    return;
    [super dealloc];
}

- (id)init {
    self = [self __init];
    if (self != nil) {
        self.backgroundImageView = [UIImage blankImage].view;
        UIView *frameView = self.frameView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 284.0, 141.0)] autorelease];
        frameView.backgroundColor = [UIColor colorWith8BitWhite:233 alpha:255];

        self.strokeView = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, frameView.frame.size.width, 0.5)];
        self.strokeView.backgroundColor = [UIColor colorWith8BitWhite:182 alpha:255];
        [frameView addSubview:self.strokeView];

        [self addSubview:frameView];
    }
    return self;
}

- (void)show {
    [super __show];

    self.titleLabel.textColor = self.bodyTextLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = self.bodyTextLabel.shadowOffset = CGSizeZero;

    self.titleLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightMedium];
    self.bodyTextLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];

    self.frameView.frame = self.bounds;

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
        frame.origin.y = highest - 0.5f;
        self.strokeView.frame = frame;
    }
}


@end
