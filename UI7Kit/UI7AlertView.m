//
//  UI7AlertView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UI7Button.h"

#import "UI7AlertView.h"

@interface UIAlertView (Private)

@property(nonatomic,readonly) UILabel *titleLabel;
@property(nonatomic,readonly) UILabel *bodyTextLabel;
@property(nonatomic,readonly) NSArray *buttons;

@end


@interface UIAlertView (Accessor)

@property(nonatomic,retain) UIView *backgroundImageView;

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

@end


@interface UIAlertButton: UIButton

@property(nonatomic,copy) NSString *title;

@end


@interface UI7AlertView ()

@property(nonatomic,assign) UIView *frameView;

@property(nonatomic,assign) UIView *strokeView;

- (void)_buttonDidSelected:(id)sender;

@end


@implementation UI7AlertView

@synthesize frameView=_frameView;
@synthesize strokeView=_strokeView;

@synthesize cancelButtonIndex;


- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super init]; // rough
    if (self != nil) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.backgroundImageView = [UIImage blankImage].view;

        UIView *frameView = self.frameView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 284.0, 141.0)] autorelease];
        frameView.backgroundColor = [UIColor iOS7BackgroundColor]; // temp

        self.strokeView = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, frameView.frame.size.width, 0.5)];
        self.strokeView.backgroundColor = [UIColor colorWith8BitWhite:182 alpha:255];
        [frameView addSubview:self.strokeView];
        
        [self addSubview:frameView];

        self.title = title;
        self.message = message;
        self.delegate = delegate;
//        self.buttons = [NSArray array];

        va_list titlep;
        va_start(titlep, otherButtonTitles);
        NSString *aTitle = otherButtonTitles;
        while (aTitle != nil) {
            [self addButtonWithTitle:aTitle];
            aTitle = va_arg(titlep, NSString *);
        }
        va_end(titlep);
        NSInteger index = [self addButtonWithTitle:cancelButtonTitle];
        self.cancelButtonIndex = index;
    }
    return self;
}

- (void)show {
//    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
//        UI7Button *button = obj;
//        CGFloat width = self.frameView.frame.size.width / self.buttons.count;
//        CGRect frame = CGRectMake(width * index, self.strokeView.frame.origin.y + 1.0f, self.frameView.frame.size.width / self.buttons.count, 45.0);
//        button.frame = frame;
//    }];

//    {
//        self.frameView.center = self.center;
//
//        [window addSubview:self];
//    }
    self.backgroundImageView.alpha = .0;
    for (UIView *view in self.backgroundImageView.subviews) {
        NSLog(@" %@ %@", view.className, view);
    }
    [super show];

    self.titleLabel.textColor = self.bodyTextLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = self.bodyTextLabel.shadowOffset = CGSizeZero;

    self.titleLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightMedium];
    self.bodyTextLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];

    {
        CGRect frame = self.strokeView.frame;
        frame.origin.y = self.bodyTextLabel.frame.origin.y + self.bodyTextLabel.frame.size.height + 29.5f;
        self.strokeView.frame = frame;
    }

    self.frameView.frame = self.bounds;

    for (UIAlertButton *button in self.buttons) {
        button.titleLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];
        [button setTitleColor:[UIColor iOS7ButtonTitleColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor iOS7ButtonTitleHighlightedColor] forState:UIControlStateHighlighted];
        button.titleLabel.shadowOffset = CGSizeZero;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];

        CGRect frame = button.frame;
        frame.size.height = 45.0;
        frame.origin.y = self.strokeView.frame.origin.y + 0.5f;
        button.frame = frame;
    }
}

//- (NSInteger)addButtonWithTitle:(NSString *)title {
//    [super addButtonWithTitle:title];
//    UI7Button *button = [UI7Button buttonWithType:UIButtonTypeCustom];
//    CGRect frame = CGRectMake(.0, .0, self.frameView.frame.size.width, 45.0);
//
//    button.frame = frame;
//    [self.frameView addSubview:button];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor iOS7ButtonTitleColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor iOS7ButtonTitleHighlightedColor] forState:UIControlStateHighlighted];
//    button.tag = self.buttons.count;
//    [button addTarget:self action:@selector(_buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.buttons = [self.buttons arrayByAddingObject:button];
//    return button.tag;
//}

//- (void)_buttonDidSelected:(id)sender {
//    id<UIAlertViewDelegate> delegate = [self delegate];
//    [delegate alertView:(id)self willDismissWithButtonIndex:[sender tag]];
//    [delegate alertView:(id)self didDismissWithButtonIndex:[sender tag]];
//    [delegate alertView:(id)self didDismissWithButtonIndex:[sender tag]];
//    [self removeFromSuperview];
//}

@end
