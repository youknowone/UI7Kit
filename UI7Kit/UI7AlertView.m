//
//  UI7AlertView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 14..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UI7Button.h"

#import "UI7AlertView.h"

@interface UI7AlertView ()

@property(nonatomic,assign) UIView *frameView;
@property(nonatomic,retain) NSArray *buttons;

@property(nonatomic,assign) UILabel *titleLabel;
@property(nonatomic,assign) UILabel *messageLabel;

@property(nonatomic,assign) UIView *strokeView;

- (void)_buttonDidSelected:(id)sender;

@end


@implementation UI7AlertView

@synthesize frameView=_frameView;
@synthesize buttons=_buttons;
@synthesize titleLabel=_titleLabel, messageLabel=_messageLabel;
@synthesize strokeView=_strokeView;

@synthesize cancelButtonIndex;

- (void)dealloc {
    self.buttons = nil;
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithFrame:CGRectMake(.0, .0, 320.0, 480.0)]; // rough
    if (self != nil) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

        UIView *frameView = self.frameView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 270.0, 100.0)] autorelease];
        frameView.backgroundColor = [UIColor iOS7BackgroundColor]; // temp
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13.0, 20.0, frameView.frame.size.width - 26.0, .0)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightMedium];
        self.titleLabel.numberOfLines = 3;
        [frameView addSubview:self.titleLabel];

        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(13.0, 20.0, frameView.frame.size.width - 26.0, .0)];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textAlignment = UITextAlignmentCenter;
        self.messageLabel.font = [UIFont iOS7SystemFontOfSize:16.0 weight:UI7FontWeightLight];
        self.messageLabel.numberOfLines = 5;
        [frameView addSubview:self.messageLabel];

        self.strokeView = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, frameView.frame.size.width, 0.5)];
        self.strokeView.backgroundColor = [UIColor colorWith8BitWhite:182 alpha:255];
        [frameView addSubview:self.strokeView];
        
        [self addSubview:frameView];

        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.buttons = [NSArray array];

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
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    self.frame = window.bounds;
    {
        CGRect frame = self.titleLabel.frame;
        self.titleLabel.text = self.title;
        CGSize size = [self.title sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(frame.size.width, INFINITY)];
        frame.size.height = size.height;
        self.titleLabel.frame = frame;
    }
    {
        CGRect frame = self.messageLabel.frame;
        frame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 2.0f;
        self.messageLabel.text = self.message;
        CGSize size = [self.message sizeWithFont:self.messageLabel.font constrainedToSize:CGSizeMake(frame.size.width, INFINITY)];
        frame.size.height = size.height;
        self.messageLabel.frame = frame;
    }
    {
        CGRect frame = self.strokeView.frame;
        frame.origin.y = self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height + 29.5f;
        self.strokeView.frame = frame;
    }
    [self.buttons applyProcedureWithIndex:^(id obj, NSUInteger index) {
        UI7Button *button = obj;
        CGFloat width = self.frameView.frame.size.width / self.buttons.count;
        CGRect frame = CGRectMake(width * index, self.strokeView.frame.origin.y + 1.0f, self.frameView.frame.size.width / self.buttons.count, 45.0);
        button.frame = frame;
    }];
    {
        CGRect frame = self.frameView.frame;
        frame.size.height = self.strokeView.frame.origin.y + 46;
        self.frameView.frame = frame;
    }
    {
        self.frameView.center = self.center;

        [window addSubview:self];
    }
}

- (NSInteger)addButtonWithTitle:(NSString *)title {
    UI7Button *button = [UI7Button buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(.0, .0, self.frameView.frame.size.width, 45.0);

    button.frame = frame;
    [self.frameView addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor iOS7ButtonTitleColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor iOS7ButtonTitleHighlightedColor] forState:UIControlStateHighlighted];
    button.tag = self.buttons.count;
    [button addTarget:self action:@selector(_buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];

    self.buttons = [self.buttons arrayByAddingObject:button];
    return button.tag;
}

- (void)_buttonDidSelected:(id)sender {
    id<UIAlertViewDelegate> delegate = [self delegate];
    [delegate alertView:(id)self willDismissWithButtonIndex:[sender tag]];
    [delegate alertView:(id)self didDismissWithButtonIndex:[sender tag]];
    [delegate alertView:(id)self didDismissWithButtonIndex:[sender tag]];
    [self removeFromSuperview];
}

@end
