//
//  UI7ActionSheet.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"

#import "UI7ActionSheet.h"

@interface UIActionSheet (Private)

@property(nonatomic,readonly) UILabel *_titleLabel;
@property(nonatomic,readonly) NSMutableArray *buttons;
@property(nonatomic,readonly) UITableView *tableView;

@end


static NSMutableDictionary *UI7ActionSheetFrameViews = nil;
static NSMutableDictionary *UI7ActionSheetStrokeViews = nil;


@interface UIActionSheet (Accessor)

@property(nonatomic,assign) UIView *frameView;
@property(nonatomic,assign) NSMutableArray *strokeView;

@end


@implementation UIActionSheet (Accessor)

- (UIView *)frameView {
    return UI7ActionSheetFrameViews[self.pointerString];
}

- (void)setFrameView:(UIView *)frameView {
    UI7ActionSheetFrameViews[self.pointerString] = frameView;
}

- (NSMutableArray *)strokeView {
    return UI7ActionSheetStrokeViews[self.pointerString];
}

- (void)setStrokeView:(NSMutableArray *)strokeView {
    UI7ActionSheetStrokeViews[self.pointerString] = strokeView;
}

@end


@implementation UIActionSheet (Patch)

- (id)init { return [super init]; }
- (id)__init { assert(NO); return nil; }
- (void)__showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated { assert(NO); }
- (void)__showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated { assert(NO); }
- (void)__showFromTabBar:(UITabBar *)view { assert(NO); }
- (void)__showFromToolbar:(UIToolbar *)view { assert(NO); }
- (void)__showInView:(UIView *)view { assert(NO); }

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    [UI7ActionSheetFrameViews removeObjectForKey:self.pointerString];
    [UI7ActionSheetStrokeViews removeObjectForKey:self.pointerString];
    [self __dealloc];
}

@end


@interface UI7ActionSheet ()

@end


@implementation UI7ActionSheet


+ (void)initialize {
    if (self == [UI7ActionSheet class]) {
        UI7ActionSheetFrameViews = [[NSMutableDictionary alloc] init];
        UI7ActionSheetStrokeViews = [[NSMutableDictionary alloc] init];

        Class origin = [UIActionSheet class];

        [origin copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [origin copyToSelector:@selector(__showFromBarButtonItem:animated:) fromSelector:@selector(showFromBarButtonItem:animated:)];
        [origin copyToSelector:@selector(__showFromRect:inView:animated:) fromSelector:@selector(showFromRect:inView:animated:)];
        [origin copyToSelector:@selector(__showFromTabBar:) fromSelector:@selector(showFromTabBar:)];
        [origin copyToSelector:@selector(__showFromToolbar:) fromSelector:@selector(showFromToolbar:)];
        [origin copyToSelector:@selector(__showInView:) fromSelector:@selector(showInView:)];
        [origin copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    Class target = [UIActionSheet class];

    [self exportSelector:@selector(init) toClass:target];
    [self exportSelector:@selector(showFromBarButtonItem:animated:) toClass:target];
    [self exportSelector:@selector(showFromRect:inView:animated:) toClass:target];
    [self exportSelector:@selector(showFromTabBar:) toClass:target];
    [self exportSelector:@selector(showFromToolbar:) toClass:target];
    [self exportSelector:@selector(showInView:) toClass:target];
    [self exportSelector:@selector(dealloc) toClass:target];
    [self exportSelector:@selector(drawRect:) toClass:target];
}

- (void)dealloc {
    [super _dealloc];
    return;
    [super dealloc];
}


- (id)init {
    self = [self __init];
    if (self != nil) {
        UIView *frameView = self.frameView = [[[UIView alloc] init] autorelease];
        frameView.backgroundColor = [UIColor colorWith8bitWhite:240 alpha:255];
        [self addSubview:frameView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // blow up stupid backgrounds >:|
}

// common method calls
// - UI7ActionSheet UIActionSheet presentSheetFromButtonBar:
// - UI7ActionSheet UIActionSheet presentSheetFromBehindView:
// - UI7ActionSheet UIActionSheet _presentSheetFromView:above:
// - layout

- (void)_setTheme {
    self.backgroundColor = [UIColor colorWith8bitWhite:122 alpha:255];

    CGRect frame = self.bounds;
    frame.origin.y = self._titleLabel.frame.origin.y + self._titleLabel.frame.size.height + 6.0f;
    self.frameView.frame = frame;
    self._titleLabel.textColor = [UIColor colorWith8bitWhite:88 alpha:255];
    self._titleLabel.shadowOffset = CGSizeZero;
    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
        UIButton *button = obj; // UIAlertButton, really
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeMedium];
        } else {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeLight];
        }
        [button setBackgroundImage:[UIImage clearImage] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage clearImage] forState:UIControlStateHighlighted];

        UIColor *color = nil;
        if (self.destructiveButtonIndex == (NSInteger)index) {
            color = [UIColor iOS7ButtonTitleEmphasizedColor];
        } else {
            color = [UIColor iOS7ButtonTitleColor];
        }
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color.highligtedColor forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
    }];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    [self __showFromBarButtonItem:item animated:animated];
    [self _setTheme];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    [self __showFromRect:rect inView:view animated:animated];
    [self _setTheme];
}

- (void)showFromTabBar:(UITabBar *)view {
    [self __showFromTabBar:view];
    [self _setTheme];
}

- (void)showFromToolbar:(UIToolbar *)view {
    [self __showFromToolbar:view];
    [self _setTheme];
}

- (void)showInView:(UIView *)view {
    [self __showInView:view];
    [self _setTheme];
}

@end
