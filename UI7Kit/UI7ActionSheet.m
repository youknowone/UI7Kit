//
//  UI7ActionSheet.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"
#import "UI7Color.h"

#import "UI7ActionSheet.h"

@interface UIActionSheet (Private)

@property(nonatomic,readonly) UILabel *_titleLabel __deprecated; // rejected
@property(nonatomic,readonly) NSMutableArray *buttons;
@property(nonatomic,readonly) UITableView *tableView;

@end


@interface UIActionSheet (Accessor)

@property(nonatomic,readonly) UILabel *titleLabel;

@end


@implementation UIActionSheet (Accessor)

NSAPropertyGetter(titleLabel, @"_titleLabel");

@end


@implementation UIActionSheet (Patch)

- (id)init { return [super init]; }
- (id)__init { assert(NO); return nil; }
- (void)__showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated { assert(NO); }
- (void)__showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated { assert(NO); }
- (void)__showFromTabBar:(UITabBar *)view { assert(NO); }
- (void)__showFromToolbar:(UIToolbar *)view { assert(NO); }
- (void)__showInView:(UIView *)view { assert(NO); }

- (void)_setTheme {
    self.opaque = NO;
    self.backgroundColor = UIColor.clearColor;

    for (id view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview]; // background image
        }
    }

    self.titleLabel.textColor = [UIColor colorWith8bitWhite:88 alpha:255];
    self.titleLabel.shadowOffset = CGSizeZero;

    BOOL isPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    CGFloat leftMargin = isPhone ? 8.0f : .0f;

    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
        UIButton *button = obj; // UIAlertButton
        
        CGRect frame = button.frame;
        frame.size = CGSizeMake(304.0f, UI7ControlRowHeight - 0.5f);
        frame.origin.x = leftMargin;
        frame.size.width = self.frame.size.width - 2 * leftMargin;
        if (self.cancelButtonIndex == (NSInteger)index) {
            frame.origin.y = self.titleLabel.frame.size.height + 45.0f + (self.buttons.count - 1) * UI7ControlRowHeight;
        } else {
            frame.origin.y = self.titleLabel.frame.size.height + 35.0f + index * UI7ControlRowHeight;
        }
        button.frame = frame;
        
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeMedium];
        } else {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeLight];
        }
        
        [button setBackgroundColor:[UIColor darkGrayColor]];
        
        UIBezierPath *path = nil;
        
        if (index == 0) {
            if (self.titleLabel.text.length == 0) {
                path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:UI7ControlRadiusSize];
            }
        } else if ((NSInteger)index == self.cancelButtonIndex) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:UI7ControlRadius];
        } else if (index == self.buttons.count - 1 - (self.cancelButtonIndex >= 0 ? 1 : 0)) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:UI7ControlRadiusSize];
        }

        button.backgroundColor = [UIColor clearColor];
        UIColor *selectedColor = [UIColor colorWith8bitWhite:231 alpha:231];
        if (path) {
            [button setBackgroundImage:[path imageWithFillColor:[UI7Color defaultBarColor]] forState:UIControlStateNormal];
        
            [button setBackgroundImage:[path imageWithFillColor:selectedColor] forState:UIControlStateHighlighted];
        } else {
            [button setBackgroundImage:[UIImage imageWithColor:[UI7Color defaultBarColor] size:button.bounds.size] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:selectedColor size:button.bounds.size] forState:UIControlStateHighlighted];
        }
        
        UIColor *color = nil;
        if ((self.destructiveButtonIndex == (NSInteger)index) && (self.destructiveButtonIndex != self.cancelButtonIndex)) {
            color = [UI7Color defaultEmphasizedColor];
        } else {
            color = [UI7Color defaultTintColor];
        }
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;

        button.opaque = NO;
    }];

    CGRect frame = self.frame;
    frame.origin.y += self.buttons.count * 9.0f;

    if (self.titleLabel.text.length > 0) {
        CGRect tframe = self.titleLabel.frame;
        tframe.origin.y += 10.0f;
        self.titleLabel.frame = tframe;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(leftMargin, 10.0f, self.frame.size.width - 2 * leftMargin, 24.5f + self.titleLabel.frame.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:UI7ControlRadiusSize];
        UIImageView *backgroundView = [[[UIImageView alloc] initWithImage:[path imageWithFillColor:[UI7Color defaultBarColor]]] autorelease];
        
        [self insertSubview:backgroundView belowSubview:self.titleLabel];
    }

    self.frame = frame;

    if (!isPhone) {
        UIView *ssuperview = self.superview.superview;
        frame = ssuperview.frame;
        frame.size.height += 45.0f;
        ssuperview.frame = frame;
        [ssuperview.subviews[0] setHidden:YES];
        UIView *dimmingView = [[[UIView alloc] initWithFrame:self.window.bounds] autorelease];
        dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.15];
        dimmingView.hidden = YES;
        [ssuperview.superview insertSubview:dimmingView belowSubview:ssuperview];
        [dimmingView setHidden:NO animated:YES];
    }
}


@end


@interface UI7ActionSheet ()

@end


@implementation UI7ActionSheet


+ (void)initialize {
    if (self == [UI7ActionSheet class]) {
        Class target = [UIActionSheet class];
        
        [target copyToSelector:@selector(__init) fromSelector:@selector(init)];
        [target copyToSelector:@selector(__showFromBarButtonItem:animated:) fromSelector:@selector(showFromBarButtonItem:animated:)];
        [target copyToSelector:@selector(__showFromRect:inView:animated:) fromSelector:@selector(showFromRect:inView:animated:)];
        [target copyToSelector:@selector(__showFromTabBar:) fromSelector:@selector(showFromTabBar:)];
        [target copyToSelector:@selector(__showFromToolbar:) fromSelector:@selector(showFromToolbar:)];
        [target copyToSelector:@selector(__showInView:) fromSelector:@selector(showInView:)];
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
    [self exportSelector:@selector(drawRect:) toClass:target];

}

- (id)init {
    self = [self __init];
    if (self != nil) {

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
