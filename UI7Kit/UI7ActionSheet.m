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


static NSMutableDictionary *UI7ActionSheetBackgroundViews = nil;
static NSMutableDictionary *UI7ActionSheetHeaderBackgroundViews = nil;
static NSMutableDictionary *UI7ActionSheetStrokeViews = nil;


@interface UIActionSheet (Accessor)

@property(nonatomic,readonly) UIView *buttonBackgroundView;
@property(nonatomic,assign) UIView *backgroundView;
@property(nonatomic,assign) UIView *headerBackgroundView;
@property(nonatomic,assign) NSMutableArray *strokeViews;

@end


@implementation UIActionSheet (Accessor)

- (UIView *)buttonBackgroundView {
    return self.subviews[0];
}

- (UIView *)backgroundView {
    return UI7ActionSheetBackgroundViews[self.pointerString];
}

- (void)setBackgroundView:(UIView *)view {
    UI7ActionSheetBackgroundViews[self.pointerString] = view;
}

- (UIView *)headerBackgroundView {
    return UI7ActionSheetHeaderBackgroundViews[self.pointerString];
}

- (void)setHeaderBackgroundView:(UIView *)view {
    UI7ActionSheetHeaderBackgroundViews[self.pointerString] = view;
}

- (NSMutableArray *)strokeViews {
    return UI7ActionSheetStrokeViews[self.pointerString];
}

- (void)setStrokeViews:(NSMutableArray *)strokeViews {
    UI7ActionSheetStrokeViews[self.pointerString] = strokeViews;
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
    [UI7ActionSheetBackgroundViews removeObjectForKey:self.pointerString];
    [UI7ActionSheetHeaderBackgroundViews removeObjectForKey:self.pointerString];
    [UI7ActionSheetStrokeViews removeObjectForKey:self.pointerString];
    [self __dealloc];
}

- (void)_setTheme {
    
    self.backgroundColor=UIColor.clearColor;
    
    CGRect frame = self.bounds;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height-self.frame.size.height;
    self.backgroundView.frame = CGRectZero;
    self._titleLabel.textColor = [UIColor colorWith8bitWhite:88 alpha:255];
    self._titleLabel.shadowOffset = CGSizeZero;
    
    self.buttonBackgroundView.backgroundColor = [UIColor colorWith8bitWhite:240 alpha:255];
    
    for (UIView *strokeView in self.strokeViews) {
        [strokeView removeFromSuperview];
    }
    
    self.strokeViews = [NSMutableArray array];
    
    for (UIButton *button in self.buttons) {
        
        NSInteger index=[self.buttons indexOfObject:button];
        
        frame = button.frame;
        frame.size = CGSizeMake(304.0f, 38.5f);
        frame.origin.x = 8.0f;
        if (self.cancelButtonIndex == index) {
            frame.origin.y = 60.0f + (self.buttons.count - 1) * 38.5f;
        } else {
            frame.origin.y = 50.0f + index * 38.5f;
        }
        button.frame = frame;
        
        if (self.cancelButtonIndex == (NSInteger)index) {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeMedium];
        } else {
            button.titleLabel.font = [UI7Font systemFontOfSize:button.titleLabel.font.pointSize attribute:UI7FontAttributeLight];
        }
        
        [button setBackgroundColor:[UIColor darkGrayColor]];
        
        UIBezierPath *path;
        
        if (index==0) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:self._titleLabel.text.length>1?CGSizeMake(0.0, 0.0):CGSizeMake(4.0, 4.0)];
        }else if (index+1==self.buttons.count) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4.0, 4.0)];
        }else if (index+2==self.buttons.count) {
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4.0, 4.0)];
        }else{
            path = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(0.0, 0.0)];
        }
        
        [button setBackgroundImage:[path imageWithFillColor:[UIColor iOS7BackgroundColor]] forState:UIControlStateNormal];
        
        UIGraphicsBeginImageContext(button.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor colorWith8bitWhite:218 alpha:255] set];
        CGContextFillRect(context, CGRectMake(8.0f, 0.0, button.frame.size.width - 16.0f, button.frame.size.height));
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [button setBackgroundImage:[path imageWithFillColor:[UIColor lightTextColor]] forState:UIControlStateHighlighted];
        
        UIColor *color = nil;
        if ((self.destructiveButtonIndex == (NSInteger)index)&&(self.destructiveButtonIndex!=self.cancelButtonIndex)) {
            color = [UIColor iOS7ButtonTitleEmphasizedColor];
        } else {
            color = [UIColor iOS7ButtonTitleColor];
        }
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
        
    }
    frame = self.frame;
    frame.origin.y += self.buttons.count * 10.0f;
    
    if (self._titleLabel.text.length>1) {
        frame.origin.y += 20;
        
        self._titleLabel.frame= CGRectMake(self._titleLabel.frame.origin.x, self._titleLabel.frame.origin.y+10, self._titleLabel.frame.size.width, self._titleLabel.frame.size.height) ;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(8.0f, 10.0f, self.frame.size.width - 16.0f, 39.0f) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4.0, 4.0)];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[path imageWithFillColor:[UIColor iOS7BackgroundColor]]];
        
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(8.0f, 49, self.frame.size.width - 16.0f, 1.0f)] autorelease];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        [self.strokeViews addObject:view];

        [self insertSubview:backgroundView belowSubview:self.buttonBackgroundView];
        self.headerBackgroundView = backgroundView;
    }
    
    self.frame = frame;
}


@end


@interface UI7ActionSheet ()

@end


@implementation UI7ActionSheet


+ (void)initialize {
    if (self == [UI7ActionSheet class]) {
        UI7ActionSheetBackgroundViews = [[NSMutableDictionary alloc] init];
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
        UIView *backgroundView = self.backgroundView = [[[UIView alloc] init] autorelease];
        backgroundView.backgroundColor = [UIColor colorWith8bitWhite:240 alpha:255];
        [self addSubview:backgroundView];
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
