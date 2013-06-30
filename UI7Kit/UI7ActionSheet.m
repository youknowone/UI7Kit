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

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
    [self __dealloc];
}

- (void)_setTheme {
    self.backgroundColor = UIColor.clearColor;
    
    self.titleLabel.textColor = [UIColor colorWith8bitWhite:88 alpha:255];
    self.titleLabel.shadowOffset = CGSizeZero;

    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
        UIButton *button = obj; // UIAlertButton
        
        CGRect frame = button.frame;
        frame.size = CGSizeMake(304.0f, 43.5f);
        frame.origin.x = 8.0f;
        if (self.cancelButtonIndex == (NSInteger)index) {
            frame.origin.y = 60.0f + (self.buttons.count - 1) * 44.0f;
        } else {
            frame.origin.y = 50.0f + index * 44.0f;
        }
        button.frame = frame;
        
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeMedium];
        } else {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeLight];
        }
        
        [button setBackgroundColor:[UIColor darkGrayColor]];
        
        UIBezierPath *path;
        
        if (index == 0) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:self.titleLabel.text.length>1?CGSizeMake(0.0, 0.0):CGSizeMake(4.0, 4.0)];
        } else if ((NSInteger)index == self.cancelButtonIndex) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4.0, 4.0)];
        } else if (index == self.buttons.count - 1 - (self.cancelButtonIndex >= 0 ? 1 : 0)) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4.0, 4.0)];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:.0f];
        }
        
        [button setBackgroundImage:[path imageWithFillColor:[UI7Color defaultBackgroundColor]] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[path imageWithFillColor:[UIColor lightTextColor]] forState:UIControlStateHighlighted];
        
        UIColor *color = nil;
        if ((self.destructiveButtonIndex == (NSInteger)index)&&(self.destructiveButtonIndex!=self.cancelButtonIndex)) {
            color = [UI7Color defaultEmphasizedColor];
        } else {
            color = [UI7Color defaultTintColor];
        }
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
    }];

    CGRect frame = self.frame;
    frame.origin.y += self.buttons.count * 4.0f;

    if (self.titleLabel.text.length > 0) {
        frame.origin.y += 20.0f;

        CGRect tframe = self.titleLabel.frame;
        tframe.origin.y += 10.0f;
        self.titleLabel.frame = tframe;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(8.0f, 10.0f, self.frame.size.width - 16.0f, 39.0f) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4.0, 4.0)];
        UIImageView *backgroundView = [[[UIImageView alloc] initWithImage:[path imageWithFillColor:[UI7Color defaultBackgroundColor]]] autorelease];
        
        [self insertSubview:backgroundView belowSubview:self.titleLabel];
    }
    
    self.frame = frame;
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
        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
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
