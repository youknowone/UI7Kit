//
//  UI7PickerView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 5..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UI7PickerView.h"

@interface UIPickerView (Accessor)

@property(strong,nonatomic) UIView *backgroundView;
@property(readonly,nonatomic) NSArray *tables;

@end


@implementation UIPickerView (Accessor)

NSAPropertyGetter(backgroundView, @"_backgroundView");
NSAPropertyRetainSetter(setBackgroundView, @"_backgroundView");
NSAPropertyGetter(tables, @"_tables");

@end


@interface UIPickerView (Patch)

@end


@implementation UI7PickerView

+ (void)initialize {
    if (self == [UI7PickerView class]) {
//        Class target = [UIPickerView class];


    }
}

+ (void)patch {

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    return self;
}

- (void)awakeFromNib {

}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor whiteColor];
    for (id v in self.subviews) {
//        [v setHidden:YES];
    }
    [self.subviews[0] setHidden:YES];
    [self.subviews[1] setHidden:YES];

//    UITableView *tableView = self.tables[0];
//    tableView.backgroundView = nil;
//    tableView.backgroundColor = nil;

//    [self.subviews[2] setHidden:YES];
//    [self.subviews[3] setHidden:YES];
    [self.subviews.lastObject setHidden:YES];

//    CALayer* mask = [[CALayer alloc] init];
//    [mask setBackgroundColor: [UIColor blackColor].CGColor];
//    [mask setFrame:  CGRectMake(10.0f, 10.0f, 280.0f, 196.0f)];
//    [mask setCornerRadius: 5.0f];
//    [self.layer setMask: mask];
//    [mask release];

}

@end


@interface _UI7PickerView: UIView

@end


@implementation _UI7PickerView


@end
