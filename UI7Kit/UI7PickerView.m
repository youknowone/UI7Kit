//
//  UI7PickerView.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 5..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UI7KitPrivate.h"
#import "UI7Font.h"
#import "UI7View.h"
#import "UI7PickerView.h"
#import "UI7TableView.h"
#import "UI7TableViewCell.h"

@interface UI7PickerLikeView ()

@property(nonatomic, strong) NSMutableArray *tables;
@property(nonatomic, strong) UIView                    *topFrame;
@property(nonatomic, strong) NSMutableArray            *dividers;
@property(nonatomic, strong) NSMutableArray            *selectionBars;
@property(nonatomic, strong) UIView                    *backgroundView;
@property(nonatomic, assign) NSInteger                  numberOfComponents;

@property(nonatomic, strong) UIImageView               *topGradient;
@property(nonatomic, strong) UIImageView               *bottomGradient;

@property(nonatomic, strong) UIView                    *foregroundView;
@property(nonatomic, strong) CALayer                   *maskGradientLayer;
@property(nonatomic, strong) UIView                    *topLineView;
@property(nonatomic, strong) UIView                    *bottomLineView;


@end

@interface _UI7PickerViewGradientView : UIView


@end

@implementation _UI7PickerViewGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end


@implementation UI7PickerLikeView

+ (BOOL)isSubclassOfClass:(Class)aClass {
    if (aClass == [UIPickerView class]) {
        return YES;
    }
    return [super isSubclassOfClass:aClass];
}

UIImage *UI7PickerLikeViewGradientImage(UIColor *maskColor, CGFloat topGradient, CGFloat buttomGradient, CGFloat height) {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0, height), NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithWhite:topGradient alpha:1.0f];
    CGGradientRef gradient = CGGradientCreateWithColors(color.CGColorSpace, (CFArrayRef)@[(id)color.CGColor, (id)[UIColor colorWithWhite:buttomGradient alpha:1.0f].CGColor], NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.5, .0), CGPointMake(0.5, height), 3);
    UIImage *maskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGImageRef maskTemplate = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskTemplate),
                                        CGImageGetHeight(maskTemplate),
                                        CGImageGetBitsPerComponent(maskTemplate),
                                        CGImageGetBitsPerPixel(maskTemplate),
                                        CGImageGetBytesPerRow(maskTemplate),
                                        CGImageGetDataProvider(maskTemplate),
                                        NULL, YES);
    CGImageRef masked = CGImageCreateWithMask([UIImage imageWithColor:maskColor size:CGSizeMake(1.0, height)].CGImage, mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
    return maskedImage;
}

- (void)_initPickerView {
    self.topGradient = [[[UIImageView alloc] init] autorelease];
    self.topGradient.userInteractionEnabled = NO;
    self.bottomGradient = [[[UIImageView alloc] init] autorelease];
    self.bottomGradient.userInteractionEnabled = NO;
    self.topLineView = [[[UIView alloc] init] autorelease];
    self.bottomLineView = [[[UIView alloc] init] autorelease];
    self.topLineView.backgroundColor = self.bottomLineView.backgroundColor = [UIColor lightGrayColor];

    [self addSubview:self.topGradient];
    [self addSubview:self.bottomGradient];
    [self addSubview:self.topLineView];
    [self addSubview:self.bottomLineView];
}

- (void)_updateGradient {
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - 36.0f) / 2;
    UIColor *maskColor = self.stackedBackgroundColor;
    self.topGradient.frame = CGRectMake(.0, .0, width, height);
    self.topLineView.frame = CGRectMake(.0, height, width, 1.0f);
    self.bottomGradient.frame = CGRectMake(.0, height + 36.0f, width, height);
    self.bottomLineView.frame = CGRectMake(.0, height + 35.0f, width, 1.0f);

    self.topGradient.image = UI7PickerLikeViewGradientImage(maskColor, .0f, .5f, height);
    self.bottomGradient.image = UI7PickerLikeViewGradientImage(maskColor, .5f, .0f, height);
}

- (void)_backgroundColorUpdated {
    [self _updateGradient];
}

- (id)initWithFrame:(CGRect)frame {
    frame.size.height = 216.0f;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:frame];
    [self _initPickerView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self _initPickerView];
    return self;
}

- (void)layoutSubviews {
    CGFloat widthSum = .0f;
    CGFloat selfWidth = self.frame.size.width;
    NSInteger tableCount = self.tables.count;
    for (NSInteger i = 0; i < tableCount; i++) {
        CGFloat width = selfWidth / tableCount;
        if ([self.delegate respondsToSelector:@selector(pickerView:widthForComponent:)]) {
            width = [self.delegate pickerView:(id)self widthForComponent:i];
        }
        widthSum += width;
        UITableView *table = self.tables[i];
        CGRect frame = table.frame;
        frame.size.width = width;
        table.frame = frame;

        CGFloat height = (self.frame.size.height - [self rowSizeForComponent:i].height) / 2;
        table.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 1.0, height)] autorelease];
        table.tableFooterView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, 1.0, height)] autorelease];
    }
    CGFloat margin = (selfWidth - widthSum) / 2;
    for (NSInteger i = 0; i < tableCount; i++) {
        UITableView *table = self.tables[i];
        CGRect frame = table.frame;
        frame.origin.x = margin;
        table.frame = frame;
        margin += frame.size.width;
    }
}

- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource {
    self->_dataSource = dataSource;
    self.tables = [NSMutableArray array];

    NSInteger number = [self.dataSource numberOfComponentsInPickerView:(id)self];
    for (NSInteger i = 0; i < number; i++) {
        UI7TableView *table = [[[UI7TableView alloc] initWithFrame:CGRectMake(.0, .0, self.frame.size.width / number, self.frame.size.height)] autorelease];
        table.showsVerticalScrollIndicator = NO;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor clearColor];
        table.rowHeight = 36.0f;
        [self addSubview:table];
        [self.tables addObject:table];
    }
    [self bringSubviewToFront:self.topGradient];
    [self bringSubviewToFront:self.bottomGradient];
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    return [self.tables[component] numberOfRowsInSection:0];
}

- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        return [self.delegate pickerView:(id)self viewForRow:row forComponent:component reusingView:nil]; // temp
    }
    return nil;
}

- (CGSize)rowSizeForComponent:(NSInteger)component {
    UITableView *table = self.tables[component];
    CGSize size = CGSizeMake(table.frame.size.width, 36.0f);
    if ([self.delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
        size.height = [self.delegate pickerView:(id)self rowHeightForComponent:component];
    }
    return size;
}

- (void)reloadAllComponents {
    for (UITableView *table in self.tables) {
        [table reloadData];
    }
}

- (void)reloadComponent:(NSInteger)component {
    [self.tables[component] reloadData];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    UITableView *table = self.tables[component];
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:animated scrollPosition:UITableViewScrollPositionMiddle];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    UITableView *table = self.tables[component];
    CGFloat rowHeight = [self rowSizeForComponent:component].height;
    NSInteger index = (NSInteger)((table.contentOffset.y + rowHeight * 0.5) / rowHeight);
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger component = [self.tables indexOfObject:scrollView];

    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        NSInteger index = [self selectedRowInComponent:component];
        [self.delegate pickerView:(id)self didSelectRow:index inComponent:component];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    UITableView *tableView = (UITableView *)scrollView;
    CGFloat rowHeight = tableView.rowHeight;
    targetContentOffset->y = (NSInteger)((targetContentOffset->y + rowHeight / 2) / rowHeight) * rowHeight;
}

#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger componentIndex = [self.tables indexOfObject:tableView];
    if (componentIndex == NSNotFound) return 0;

    return [self.dataSource pickerView:(id)self numberOfRowsInComponent:componentIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger componentIndex = [self.tables indexOfObject:tableView];
    if (componentIndex == NSNotFound) return nil;

    NSString *identifier = [@"%d" format0:nil, componentIndex];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (id)[UI7TableViewCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.selectedBackgroundView = [UIColor clearColor].image.view;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UI7Font iOS7SystemFontOfSize:cell.textLabel.font.pointSize attribute:UI7FontAttributeLight]; // weird behavior
    }
    UIView *view = [self viewForRow:indexPath.row forComponent:componentIndex];
    if (view) {
        
    } else {
        NSString *title = @"?";
        if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
            title = [self.delegate pickerView:(id)self titleForRow:indexPath.row forComponent:componentIndex];
        }
        cell.textLabel.text = title;
    }
    return cell;
}

@end


@interface UIPickerView (Accessor)

@property(strong,nonatomic) UIView *backgroundView;
@property(readonly,nonatomic) NSArray *tables;

@property(readonly,nonatomic) UIImageView *topGradient;
@property(readonly,nonatomic) UIImageView *bottomGradient;

@end


@implementation UIPickerView (Accessor)

NSAPropertyGetter(backgroundView, @"_backgroundView");
NSAPropertyRetainSetter(setBackgroundView, @"_backgroundView");
NSAPropertyGetter(tables, @"_tables");
NSAPropertyGetter(topGradient, @"_topGradient");
NSAPropertyGetter(bottomGradient, @"_bottomGradient");

@end


@implementation UIPickerView (Patch)

- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

@end


@implementation UI7PickerView

+ (void)initialize {
    if (self == [UI7PickerView class]) {
        Class target = [UIPickerView class];
        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UIPickerView class];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
}

- (id)initWithFrame:(CGRect)frame {
    NSString *className = self.class.name;
    if ([UIDevice currentDevice].needsUI7Kit && ([className isEqual:@"UIPickerView"] || [className isEqual:@"UI7PickerView"])) {
        [self release];
        return (id)[[UI7PickerLikeView alloc] initWithFrame:frame];
    }
    self = [self __initWithFrame:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *className = self.class.name;
    if ([UIDevice currentDevice].needsUI7Kit && ([className isEqual:@"UIPickerView"] || [className isEqual:@"UI7PickerView"])) {
        [self release];
        return (id)[[UI7PickerLikeView alloc] initWithCoder:aDecoder];
    }
    self = [self __initWithCoder:aDecoder];
    return self;
}

@end
