//
//  UI7ActionSheet.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

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
        [origin copyToSelector:@selector(__showInView:) fromSelector:@selector(showInView:)];
        [origin copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UIActionSheet class];

    [source exportSelector:@selector(init) toClass:target];
    [source exportSelector:@selector(showInView:) toClass:target];
    [source exportSelector:@selector(dealloc) toClass:target];
    [source exportSelector:@selector(drawRect:) toClass:target];
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
        frameView.backgroundColor = [UIColor colorWith8BitWhite:240 alpha:255];
        [self addSubview:frameView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // blow up stupid backgrounds >:|
}

- (void)showInView:(UIView *)view {
    [self __showInView:view];
    self.backgroundColor = [UIColor colorWith8BitWhite:122 alpha:255];
    
    CGRect frame = self.bounds;
    frame.origin.y = self._titleLabel.frame.origin.y + self._titleLabel.frame.size.height + 6.0f;
    self.frameView.frame = frame;
    self._titleLabel.textColor = [UIColor colorWith8BitWhite:88 alpha:255];
    self._titleLabel.shadowOffset = CGSizeZero;
    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
        UIButton *button = obj; // UIAlertButton, really
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UIFont iOS7SystemFontOfSize:button.titleLabel.font.pointSize weight:@"Medium"];
        } else {
            button.titleLabel.font = [UIFont iOS7SystemFontOfSize:button.titleLabel.font.pointSize weight:@"Light"];
        }
        [button setBackgroundImage:[UIImage blankImage] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage blankImage] forState:UIControlStateHighlighted];

        if (self.destructiveButtonIndex == (NSInteger)index) {
            [button setTitleColor:[UI7Kit kit].tintColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor iOS7ButtonTitleEmphasizedHighlightedColor] forState:UIControlStateHighlighted];
        } else {
            [button setTitleColor:[UI7Kit kit].tintColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor iOS7ButtonTitleHighlightedColor] forState:UIControlStateHighlighted];
        }
        button.titleLabel.shadowOffset = CGSizeZero;
    }];
}

@end
