//
//  UI7TableViewCell.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 8. 1..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7View.h"
#import "UI7Font.h"
#import "UI7Color.h"
#import "UI7TableViewCell.h"

@interface UITableViewCell (Accessor)

@property(nonatomic,assign) UITableView *tableView;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,assign,setter=___setAccessoryType:) UITableViewCellAccessoryType ___accessoryType;

@end


@implementation UITableViewCell (Accessor)

//NSAPropertyGetter(tableView, @"_tableView");

- (UITableView *)tableView {
    return [self associatedObjectForKey:@"UI7TableViewCellTableView"];
}

- (void)setTableView:(UITableView *)tableView {
    [self setAssociatedObject:tableView forKey:@"UI7TableViewCellTableView" policy:OBJC_ASSOCIATION_ASSIGN];
}

- (NSIndexPath *)indexPath {
    return [self associatedObjectForKey:@"UI7TableViewCellIndexPath"];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [self setAssociatedObject:indexPath forKey:@"UI7TableViewCellIndexPath" policy:OBJC_ASSOCIATION_RETAIN];
}

- (UITableViewCellAccessoryType)___accessoryType {
    NSNumber *type = [self associatedObjectForKey:@"UI7TableViewCellAccessoryType"];
    return type.integerValue;
}

- (void)___setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    [self setAssociatedObject:@(accessoryType) forKey:@"UI7TableViewCellAccessoryType"];
}

@end


@interface UITableViewCell (Private)

- (void)setTableViewStyle:(int)style;
- (void)_setTableBackgroundCGColor:(CGColorRef)color withSystemColorName:(id)name;

@end


@implementation UITableViewCell (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier { assert(NO); return nil; }
- (UIColor *)__tintColor { assert(NO); return  nil; }
- (UITableViewCellAccessoryType)__accessoryType { assert(NO); return 0; }
- (void)__setAccessoryType:(UITableViewCellAccessoryType)accessoryType { assert(NO); }
- (void)__setAccessoryView:(UIView *)accessoryView { assert(NO); }
- (void)__setBackgroundColor:(UIColor *)backgroundColor { assert(NO); }
- (void)__setTableViewStyle:(int)style { assert(NO); }

- (void)_tableViewCellInit {
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor; // FIXME: not sure
    self.backgroundView = [[[UIView alloc] init] autorelease];
    self.selectedBackgroundView = [[[UIView alloc] init] autorelease];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWith8bitWhite:217 alpha:255];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)_accessoryButtonTapped:(id)sender {
    id<UITableViewDelegate> delegate = self.tableView.delegate;
    if ([delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:self.indexPath];
    }
}

- (UIColor *)_tintColor {
    UIColor *color = [self __tintColor];
    if (color == nil) {
        color = [self.tableView tintColor];
    }
    return color;
}

- (void)_tintColorUpdated {
    if (self.accessoryType == UITableViewCellAccessoryCheckmark) {
        UIColor *tintColor = self.tintColor;
        if (tintColor) {
            UIImageView *markView = (id)self.accessoryView;
            markView.image = [markView.image imageByFilledWithColor:tintColor];
        }
    }
}

@end


@implementation UI7TableViewCell

UIImage *UI7TableViewCellAccessoryDisclosureIndicatorImage = nil;
UIImage *UI7TableViewCellAccessoryCheckmarkImage = nil;

UIImage *UI7TableViewCellAccessoryDisclosureIndicatorImageCreate() {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(12.0, 13.0), NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitRed:199 green:199 blue:204 alpha:255] setFill];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 3.0/2, .0);
    CGContextAddLineToPoint(context, 16.0/2, 13.0/2);
    CGContextAddLineToPoint(context, 3.0/2, 26.0/2);
    CGContextAddLineToPoint(context, .0/2, 23.0/2);
    CGContextAddLineToPoint(context, .0/2, 22.0/2);
    CGContextAddLineToPoint(context, 9.0/2, 13.0/2);
    CGContextAddLineToPoint(context, .0/2, 4.0/2);
    CGContextAddLineToPoint(context, .0/2, 3.0/2);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *UI7TableViewCellAccessoryCheckmarkImageCreate() {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(14.0, 11.0), NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[[UI7Kit kit] tintColor] setFill];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 23.0/2, .0);
    CGContextAddLineToPoint(context, 26.0/2, 3.0/2);
    CGContextAddLineToPoint(context, 9.0/2, 20.0/2);
    CGContextAddLineToPoint(context, 8.0/2, 20.0/2);
    CGContextAddLineToPoint(context, .0/2, 12.0/2);
    CGContextAddLineToPoint(context, 3.0/2, 9.0/2);
    CGContextAddLineToPoint(context, 8.0/2, 14.0/2);
    CGContextAddLineToPoint(context, 9.0/2, 14.0/2);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)initialize {
    if (self == [UI7TableViewCell class]) {
        Class target = [UITableViewCell class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithStyle:reuseIdentifier:) fromSelector:@selector(initWithStyle:reuseIdentifier:)];
        [target copyToSelector:@selector(__tintColor) fromSelector:@selector(tintColor)];
        [target copyToSelector:@selector(__accessoryType) fromSelector:@selector(accessoryType)];
        [target copyToSelector:@selector(__setAccessoryType:) fromSelector:@selector(setAccessoryType:)];
        [target copyToSelector:@selector(__setAccessoryView:) fromSelector:@selector(setAccessoryView:)];
        [target copyToSelector:@selector(__setBackgroundColor:) fromSelector:@selector(setBackgroundColor:)];
        [target copyToSelector:@selector(__setTableViewStyle:) fromSelector:@selector(setTableViewStyle:)];

        UI7TableViewCellAccessoryDisclosureIndicatorImage = [UI7TableViewCellAccessoryDisclosureIndicatorImageCreate() retain];
        UI7TableViewCellAccessoryCheckmarkImage = [UI7TableViewCellAccessoryCheckmarkImageCreate() retain];
    }
}

+ (void)patch {
    Class target = [UITableViewCell class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithStyle:reuseIdentifier:) toClass:target];
    [self exportSelector:@selector(accessoryType) toClass:target];
    [self exportSelector:@selector(setAccessoryType:) toClass:target];
    [self exportSelector:@selector(setAccessoryView:) toClass:target];
    [self exportSelector:@selector(setBackgroundColor:) toClass:target];
    [self exportSelector:@selector(setTableViewStyle:) toClass:target];
    [self exportSelector:@selector(_setTableBackgroundCGColor:withSystemColorName:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        UIColor *backgroundColor = [aDecoder decodeObjectForKey:@"UIBackgroundColor"];
        [self _tableViewCellInit];
        if (backgroundColor) {
            self.backgroundColor = backgroundColor;
        }
        if (self.accessoryView == nil) {
            self.accessoryType = [self __accessoryType]; // trigger patched setter
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self __initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        switch (style) {
            case UITableViewCellStyleDefault:
            case UITableViewCellStyleSubtitle: {
                self.textLabel.font = [UI7Font systemFontOfSize:18.0f attribute:UI7FontAttributeNone];
                self.detailTextLabel.font = [UI7Font systemFontOfSize:12.0f attribute:UI7FontAttributeNone];
            }   break;
            case UITableViewCellStyleValue1: {
                UIFont *font = [UI7Font systemFontOfSize:17.0f attribute:UI7FontAttributeNone];
                self.textLabel.font = font;
                self.detailTextLabel.font = font;
            }   break;
            case UITableViewCellStyleValue2: {
                UIFont *font = [UI7Font systemFontOfSize:14.0f attribute:UI7FontAttributeNone];
                self.textLabel.font = font;
                self.detailTextLabel.font = font;
            }   break;
            default:
                break;
        }
        [self _tableViewCellInit];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self __setBackgroundColor:backgroundColor];
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setTableViewStyle:(int)style {
    UIColor *backgroundColor = self.backgroundColor;
    [self __setTableViewStyle:style];
    self.backgroundColor = backgroundColor;
}

- (void)_setTableBackgroundCGColor:(CGColorRef)color withSystemColorName:(id)name {
    // NOTE: Do nothing here!
}

- (void)setAccessoryView:(UIView *)accessoryView {
    self.___accessoryType = UITableViewCellAccessoryNone;
    [self __setAccessoryView:accessoryView];
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wswitch"
#endif
    switch (accessoryType) {
        case UITableViewCellAccessoryNone: {
            [self __setAccessoryView:nil];
        }   break;
        case UITableViewCellAccessoryDisclosureIndicator: {
            [self __setAccessoryView:UI7TableViewCellAccessoryDisclosureIndicatorImage.view];
        }   break;
        case UITableViewCellAccessoryDetailDisclosureButton: {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button addTarget:self action:@selector(_accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

            UIImageView *indicator = UI7TableViewCellAccessoryDisclosureIndicatorImage.view;
            CGRect frame = indicator.frame;
            frame.origin = CGPointMake(button.frame.size.width + 6.0f, (button.frame.size.height - indicator.frame.size.height) / 2);
            indicator.frame = frame;

            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, button.frame.size.width + 10.0f + indicator.frame.size.width, button.frame.size.height)];
            [view addSubview:button];
            [view addSubview:indicator];

            [self __setAccessoryView:view];
        }   break;
        case UITableViewCellAccessoryDetailButton: {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button addTarget:self action:@selector(_accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self __setAccessoryView:button];
        }   break;
        case UITableViewCellAccessoryCheckmark: {
            [self __setAccessoryView:UI7TableViewCellAccessoryCheckmarkImage.view];
        }   break;
        default:
            [self __setAccessoryType:accessoryType];
            break;
    }
    self.___accessoryType = accessoryType;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    #pragma clang diagnostic pop
#endif
}

- (UITableViewCellAccessoryType)accessoryType {
    return self.___accessoryType;
}

@end
