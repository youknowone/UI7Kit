//
//  UI7TableView.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitPrivate.h"
#import "UI7Font.h"
#import "UI7Color.h"

#import "UI7TableView.h"

CGFloat UI7TableViewGroupedTableSectionSeperatorHeight = 28.0f;

@interface UITableViewCell (Accessor)

@property(nonatomic,assign) UITableView *tableView;
@property(nonatomic,strong) NSIndexPath *indexPath;

@end


@interface UITableView (Private)

- (void)_updateVisibleCellsNow:(BOOL)flag;

@end


@implementation UITableView (Patch)

UIColor *UI7TableViewGroupedViewPatternColor = nil;

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame style:(UITableViewStyle)style { assert(NO); return nil; }
- (void)__setDelegate:(id<UITableViewDelegate>)delegate { assert(NO); return; }
- (void)__setDataSource:(id<UITableViewDataSource>)dataSource { assert(NO); return; }
- (UITableViewStyle)__style { assert(NO); return 0; }
- (void)__updateVisibleCellsNow:(BOOL)flag { assert(NO); }

- (void)_tableViewInit {

}

- (void)_tableViewInitGrouped {
    if (UI7TableViewGroupedViewPatternColor == nil) {
        UI7TableViewGroupedViewPatternColor = [[[UITableView alloc] __initWithFrame:CGRectZero style:UITableViewStyleGrouped] autorelease].backgroundColor;
    }

    self.backgroundView = nil;
    if (self.separatorStyle == UITableViewCellSeparatorStyleSingleLineEtched) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)awakeFromNib { }

- (id)__dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:identifier];
}

@end


//@implementation NSCoder (UI7TableView)
//
//- (NSInteger)__decodeIntegerForKey:(NSString *)key { assert(NO); }
//
//- (NSInteger)_UI7TableView_decodeIntegerForKey:(NSString *)key {
//    if ([key isEqualToString:@"UIStyle"]) {
//        return (NSInteger)UITableViewStylePlain;
//    }
//    return [self __decodeIntegerForKey:key];
//}
//
//@end


@protocol UI7TableViewDelegate

- (UIView *)__tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)__tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)__tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)__tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

@end


@implementation UI7TableView

+ (void)initialize {
    if (self == [UI7TableView class]) {
        Class target = [UITableView class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__initWithFrame:style:) fromSelector:@selector(initWithFrame:style:)];
        [target copyToSelector:@selector(__setDelegate:) fromSelector:@selector(setDelegate:)];
        [target copyToSelector:@selector(__setDataSource:) fromSelector:@selector(setDataSource:)];
        [target copyToSelector:@selector(__style) fromSelector:@selector(style)];
        [target copyToSelector:@selector(__updateVisibleCellsNow:) fromSelector:@selector(_updateVisibleCellsNow:)];
    }
}

+ (void)patch {
    Class target = [UITableView class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(initWithFrame:style:) toClass:target];
    [self exportSelector:@selector(awakeFromNib) toClass:target];
    [self exportSelector:@selector(setDelegate:) toClass:target];
    [self exportSelector:@selector(setDataSource:) toClass:target];
    [self exportSelector:@selector(style) toClass:target];
    [self exportSelector:@selector(_updateVisibleCellsNow:) toClass:target];

    if (![target methodObjectForSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        [target addMethodForSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) fromMethod:[self methodObjectForSelector:@selector(__dequeueReusableCellWithIdentifier:forIndexPath:)]];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
//    UITableViewStyle style = UITableViewStylePlain;
//    if ([aDecoder containsValueForKey:@"UIStyle"]) {
//        style = [aDecoder decodeIntegerForKey:@"UIStyle"];
//        if (style == UITableViewStyleGrouped) {
//            NSAMethod *decode = [aDecoder.class methodObjectForSelector:@selector(decodeIntegerForKey:)];
//            [aDecoder.class methodObjectForSelector:@selector(__decodeIntegerForKey:)].implementation = decode.implementation;
//            decode.implementation = [aDecoder.class methodObjectForSelector:@selector(_UI7TableView_decodeIntegerForKey:)].implementation;
//        }
//    }
    self = [self __initWithCoder:aDecoder];
//    if (style == UITableViewStyleGrouped) {
//        NSAMethod *decode = [aDecoder.class methodObjectForSelector:@selector(decodeIntegerForKey:)];
//        decode.implementation = [aDecoder.class methodImplementationForSelector:@selector(__decodeIntegerForKey:)];
//        if (self) {
//            [UI7TableViewStyleIsGrouped setObject:@(YES) forKey:self.pointerString];
//        }
//    }
    if (self) {
        if (self.__style == UITableViewStyleGrouped) {
            [self _tableViewInitGrouped];
            UIColor *color = [aDecoder decodeObjectForKey:@"UIBackgroundColor"];
            if (color == UI7TableViewGroupedViewPatternColor) {
                self.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
            }
        }
        [self _tableViewInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _tableViewInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [self __initWithFrame:frame style:style];
    if (self) {
        if (style == UITableViewStyleGrouped) {
            [self _tableViewInitGrouped];
        }
        [self _tableViewInit];
    }
    return self;
}

- (void)awakeFromNib {
    if (self.__style == UITableViewStyleGrouped && self.superview == nil && [self.backgroundColor isEqual:[UIColor clearColor]]) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (UITableViewStyle)style {
    return UITableViewStylePlain;
}

CGFloat _UI7TableViewDelegateNoHeightForHeaderFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    return -1.0f;
}

CGFloat _UI7TableViewDelegateHeightForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    CGFloat height = [self __tableView:tableView heightForHeaderInSection:section];
    if (height != -1.0f) {
        return height;
    }
    height = .0f;
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
//    if ([UI7TableViewStyleIsGrouped containsKey:tableView.pointerString]) {
    if (tableView.__style == UITableViewStyleGrouped) {
        if (title.length > 0) {
            height = UI7TableViewGroupedTableSectionSeperatorHeight + 20.0f;
        } else {
            height = UI7TableViewGroupedTableSectionSeperatorHeight;
        }
    } else {
        if (title.length > 0) {
            height = tableView.sectionHeaderHeight;
        }
    }
    return height;
}

CGFloat _UI7TableViewDelegateHeightForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    CGFloat height = [self __tableView:tableView heightForFooterInSection:section];
    if (height != -1.0f) {
        return height;
    }
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title.length > 0) {
        if (tableView.__style == UITableViewStyleGrouped) {
            return 25.0;
        }
        return tableView.sectionFooterHeight;
    }
    return .0;
}

UIView *_UI7TableViewDelegateNilViewForHeaderFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    return nil;
}

UIView *_UI7TableViewDelegateViewForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    UIView *view = [self __tableView:tableView viewForHeaderInSection:section];
    if (view) {
        return view;
    }
    BOOL grouped = tableView.__style == UITableViewStyleGrouped;
    CGFloat height = [tableView.delegate tableView:tableView heightForHeaderInSection:section];
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        if (grouped) {
            UIView *header = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, UI7TableViewGroupedTableSectionSeperatorHeight)] autorelease];
            header.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
            return header;
        } else {
            return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        }
    }

    CGFloat groupHeight = grouped ? UI7TableViewGroupedTableSectionSeperatorHeight : .0f;
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(.0, groupHeight, tableView.frame.size.width, height - groupHeight)] autorelease];

    if (grouped) {
        label.text = [@"   " stringByAppendingString:[title uppercaseString]];
        label.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeNone];
        label.textColor = [UIColor colorWith8bitWhite:77 alpha:255];
        label.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
    } else {
        label.text = [@"    " stringByAppendingString:title];
        label.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeMedium];
        label.backgroundColor = [UIColor colorWith8bitRed:248 green:248 blue:248 alpha:255];
    }

    if (grouped) {
        view = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
        [view addSubview:label];
        view.backgroundColor = label.backgroundColor;
    } else {
        view = label;
    }
    return view;
}

UIView *_UI7TableViewDelegateViewForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    UIView *view = [self __tableView:tableView viewForFooterInSection:section];
    if (view) {
        return view;
    }
    CGFloat height = [tableView.delegate tableView:tableView heightForFooterInSection:section];
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title == nil) {
        return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    }
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
    if (tableView.__style == UITableViewStyleGrouped) {
        label.text = [@"   " stringByAppendingString:title];
        label.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeNone];
        label.textColor = [UIColor colorWith8bitWhite:128 alpha:255];
        label.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
    } else {
        label.text = [@"    " stringByAppendingString:title]; // TODO: do this pretty later
        label.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeMedium];
        label.backgroundColor = [UIColor colorWith8bitRed:248 green:248 blue:248 alpha:255];
    }
    return label;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    [self __setDataSource:dataSource];
    if (self.delegate) {
        id delegate = self.delegate;
        [self __setDelegate:nil];
        self.delegate = delegate;
    }
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (self.delegate) {
//        Class delegateClass = [(NSObject *)self.delegate class];
//        if ([delegateClass methodImplementationForSelector:@selector(tableView:viewForHeaderInSection:)] == (IMP)UI7TableViewDelegateViewForHeaderInSection) {
//            // TODO: probably we should remove this methods.
//            //            class_removeMethods(￼, ￼)
//        }
    }
    if (delegate) {
        Class delegateClass = [(NSObject *)delegate class];
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
            if ([delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
                if (![delegateClass methodObjectForSelector:@selector(__tableView:viewForHeaderInSection:)]) {
                    [delegateClass addMethodForSelector:@selector(__tableView:viewForHeaderInSection:) fromMethod:[delegateClass methodObjectForSelector:@selector(tableView:viewForHeaderInSection:)]];
                    [delegateClass addMethodForSelector:@selector(tableView:viewForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateViewForHeaderInSection types:@"@16@0:4@8i12"];
                    [delegateClass methodObjectForSelector:@selector(tableView:viewForHeaderInSection:)].implementation = (IMP)_UI7TableViewDelegateViewForHeaderInSection;
                }
            } else {
                [delegateClass addMethodForSelector:@selector(__tableView:viewForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateNilViewForHeaderFooterInSection types:@"@16@0:4@8i12"];
                [delegateClass addMethodForSelector:@selector(tableView:viewForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateViewForHeaderInSection types:@"@16@0:4@8i12"];
            }
            if ([delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
                if (![delegateClass methodObjectForSelector:@selector(__tableView:heightForHeaderInSection:)]) {
                    [delegateClass addMethodForSelector:@selector(__tableView:heightForHeaderInSection:) fromMethod:[delegateClass methodObjectForSelector:@selector(tableView:heightForHeaderInSection:)]];
                    [delegateClass addMethodForSelector:@selector(tableView:heightForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateHeightForHeaderInSection types:@"@16@0:4@8i12"];
                    [delegateClass methodObjectForSelector:@selector(tableView:heightForHeaderInSection:)].implementation = (IMP)_UI7TableViewDelegateHeightForHeaderInSection;
                }
            } else {
                [delegateClass addMethodForSelector:@selector(__tableView:heightForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateNoHeightForHeaderFooterInSection types:@"f16@0:4@8i12"];
                [delegateClass addMethodForSelector:@selector(tableView:heightForHeaderInSection:) implementation:(IMP)_UI7TableViewDelegateHeightForHeaderInSection types:@"f16@0:4@8i12"];
            }
        }
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
            if ([delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
                if (![delegateClass methodObjectForSelector:@selector(__tableView:viewForFooterInSection:)]) {
                    [delegateClass addMethodForSelector:@selector(__tableView:viewForFooterInSection:) fromMethod:[delegateClass methodObjectForSelector:@selector(tableView:viewForFooterInSection:)]];
                    [delegateClass addMethodForSelector:@selector(tableView:viewForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateViewForFooterInSection types:@"@16@0:4@8i12"];
                    [delegateClass methodObjectForSelector:@selector(tableView:viewForFooterInSection:)].implementation = (IMP)_UI7TableViewDelegateViewForFooterInSection;
                }
            } else {
                [delegateClass addMethodForSelector:@selector(__tableView:viewForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateNilViewForHeaderFooterInSection types:@"@16@0:4@8i12"];
                [delegateClass addMethodForSelector:@selector(tableView:viewForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateViewForFooterInSection types:@"@16@0:4@8i12"];
            }
            if ([delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                if (![delegateClass methodObjectForSelector:@selector(__tableView:heightForFooterInSection:)]) {
                    [delegateClass addMethodForSelector:@selector(__tableView:heightForFooterInSection:) fromMethod:[delegateClass methodObjectForSelector:@selector(tableView:heightForFooterInSection:)]];
                    [delegateClass addMethodForSelector:@selector(tableView:heightForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateHeightForFooterInSection types:@"f16@0:4@8i12"];
                    [delegateClass methodObjectForSelector:@selector(tableView:heightForFooterInSection:)].implementation = (IMP)_UI7TableViewDelegateHeightForFooterInSection;
                }
            } else {
                [delegateClass addMethodForSelector:@selector(__tableView:heightForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateNoHeightForHeaderFooterInSection types:@"f16@0:4@8i12"];
                [delegateClass addMethodForSelector:@selector(tableView:heightForFooterInSection:) implementation:(IMP)_UI7TableViewDelegateHeightForFooterInSection types:@"f16@0:4@8i12"];
            }
        }
    }
    [self __setDelegate:delegate];
}

- (void)_updateVisibleCellsNow:(BOOL)flag {
    // NOTE: Workaround for indexPathsForVisibleRows overriding, especially for Sensible table view.
    if ([self associatedObjectForKey:@"UI7TableViewCellUpdating"]) {
        return;
    }
    [self setAssociatedObject:@(YES) forKey:@"UI7TableViewCellUpdating"];

    [self __updateVisibleCellsNow:flag];
    for (NSIndexPath *path in self.indexPathsForVisibleRows) {
        UITableViewCell *cell = [self cellForRowAtIndexPath:path];
        cell.tableView = self;
        cell.indexPath = path;
        [cell _tintColorUpdated];
    }

    [self setAssociatedObject:nil forKey:@"UI7TableViewCellUpdating"];
}

// TODO: ok.. do this next time.
//- (BOOL)_delegateWantsHeaderViewForSection:(NSUInteger)section {
//    return YES;
//}
//
//- (BOOL)_delegateWantsHeaderTitleForSection:(NSUInteger)section {
//    return YES;
//}
//
//- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section {
//    UITableViewHeaderFooterView *view = [super headerViewForSection:section];
//    
//    return view;
//}

@end




@implementation UI7TableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [super tableView:tableView heightForHeaderInSection:section];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [super tableView:tableView viewForHeaderInSection:section];
    return view;
}

@end
