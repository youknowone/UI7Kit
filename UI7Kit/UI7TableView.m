//
//  UI7TableView.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Font.h"
#import "UI7Color.h"

#import "UI7TableView.h"

//NSMutableDictionary *UI7TableViewStyleIsGrouped = nil;

@implementation UITableView (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__setDelegate:(id<UITableViewDelegate>)delegate { assert(NO); return; }
- (UITableViewStyle)__style { assert(NO); return 0; }

- (void)_tableViewInit {

}

- (void)__dealloc { assert(NO); }
- (void)_dealloc {
//    if ([UI7TableViewStyleIsGrouped containsKey:self.pointerString]) {
//        [UI7TableViewStyleIsGrouped removeObjectForKey:self.pointerString];
//    }
    [self __dealloc];
}

@end


@implementation NSCoder (UI7TableView)

- (NSInteger)__decodeIntegerForKey:(NSString *)key { assert(NO); }

- (NSInteger)_UI7TableView_decodeIntegerForKey:(NSString *)key {
    if ([key isEqualToString:@"UIStyle"]) {
        return (NSInteger)UITableViewStylePlain;
    }
    return [self __decodeIntegerForKey:key];
}

@end


@implementation UI7TableView

// TODO: implement 'setAccessoryType' to fake accessories.

+ (void)initialize {
    if (self == [UI7TableView class]) {
//        UI7TableViewStyleIsGrouped = [[NSMutableDictionary alloc] init];

        Class target = [UITableView class];

        [target copyToSelector:@selector(__dealloc) fromSelector:@selector(dealloc)];
        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [target copyToSelector:@selector(__setDelegate:) fromSelector:@selector(setDelegate:)];
        [target copyToSelector:@selector(__style) fromSelector:@selector(style)];
    }
}

+ (void)patch {
    Class target = [UITableView class];

    [self exportSelector:@selector(dealloc) toClass:target];
    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
    [self exportSelector:@selector(setDelegate:) toClass:target];
    [self exportSelector:@selector(style) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
//    UITableViewStyle style = UITableViewStylePlain;
//    if ([aDecoder containsValueForKey:@"UIStyle"]) {
//        style = [aDecoder decodeIntegerForKey:@"UIStyle"];
//        if (style == UITableViewStyleGrouped) {
//            NSAMethod *decode = [aDecoder.class methodForSelector:@selector(decodeIntegerForKey:)];
//            [aDecoder.class methodForSelector:@selector(__decodeIntegerForKey:)].implementation = decode.implementation;
//            decode.implementation = [aDecoder.class methodForSelector:@selector(_UI7TableView_decodeIntegerForKey:)].implementation;
//        }
//    }
    self = [self __initWithCoder:aDecoder];
//    if (style == UITableViewStyleGrouped) {
//        NSAMethod *decode = [aDecoder.class methodForSelector:@selector(decodeIntegerForKey:)];
//        decode.implementation = [aDecoder.class methodImplementationForSelector:@selector(__decodeIntegerForKey:)];
//        if (self) {
//            [UI7TableViewStyleIsGrouped setObject:@(YES) forKey:self.pointerString];
//        }
//    }
    if (self) {
        if (self.__style == UITableViewStyleGrouped) {
            self.backgroundColor = [UIColor clearColor];
            self.backgroundView = nil;
            if (self.separatorStyle == UITableViewCellSeparatorStyleSingleLineEtched) {
                self.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    self = [self __initWithFrame:frame];
    if (self) {
//        [UI7TableViewStyleIsGrouped setObject:@(YES) forKey:self.pointerString];
        [self _tableViewInit];
    }
    return self;
}

- (void)dealloc {
    [self _dealloc];
    return;
    [super dealloc];
}

- (UITableViewStyle)style {
    return UITableViewStylePlain;
}

CGFloat UI7TableViewDelegateHeightForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    CGFloat height = .0f;
//    if ([UI7TableViewStyleIsGrouped containsKey:tableView.pointerString]) {
    if (tableView.__style == UITableViewStyleGrouped) {
        if (title) {
            height = 55.0f;
        } else {
            height = 30.0f;
        }
    } else {
        if (title) {
            height = tableView.sectionHeaderHeight;
        }
    }
    return height;
}

CGFloat UI7TableViewDelegateHeightForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title) {
        return tableView.sectionFooterHeight;
    }
    return .0;
}

UIView *UI7TableViewDelegateViewForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    BOOL grouped = tableView.__style == UITableViewStyleGrouped;
    CGFloat height = [tableView.delegate tableView:tableView heightForHeaderInSection:section];
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        if (grouped) {
            UIView *header = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, 30.0f)] autorelease];
            header.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
            return header;
        } else {
            return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        }
    }

    CGFloat groupHeight = grouped ? 30.0f : .0f;
    UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(.0, groupHeight, tableView.frame.size.width, height - groupHeight)] autorelease];
    if (grouped) {
        view.backgroundColor = [UI7Color groupedTableViewSectionBackgroundColor];
    } else {
        view.backgroundColor = [UI7Kit kit].backgroundColor;
    }

    if (grouped) {
        view.text = [@"   " stringByAppendingString:[title uppercaseString]];
        view.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeLight];
        view.textColor = [UIColor darkGrayColor];
    } else {
        view.text = [@"    " stringByAppendingString:title];
        view.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeBold];
    }

    if (grouped) {
        UIView *holder = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
        [holder addSubview:view];
        holder.backgroundColor = view.backgroundColor;
        view = (id)holder;
    }
    return view;
}

UIView *UI7TableViewDelegateViewForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    CGFloat height = [tableView.delegate tableView:tableView heightForFooterInSection:section];
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title == nil) {
        return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    }
    
    UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
    view.backgroundColor = [UI7Kit kit].backgroundColor;
    view.text = [@"    " stringByAppendingString:title]; // TODO: do this pretty later
    view.font = [UI7Font systemFontOfSize:14.0 attribute:UI7FontAttributeBold];
    return view;
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
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)] && ![delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            [delegateClass addMethodForSelector:@selector(tableView:viewForHeaderInSection:) implementation:(IMP)UI7TableViewDelegateViewForHeaderInSection types:@"@16@0:4@8i12"];
            if (![delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
                [delegateClass addMethodForSelector:@selector(tableView:heightForHeaderInSection:) implementation:(IMP)UI7TableViewDelegateHeightForHeaderInSection types:@"f16@0:4@8i12"];
            }
        }
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)] && ![delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            [delegateClass addMethodForSelector:@selector(tableView:viewForFooterInSection:) implementation:(IMP)UI7TableViewDelegateViewForFooterInSection types:@"@16@0:4@8i12"];
            if (![delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                [delegateClass addMethodForSelector:@selector(tableView:heightForFooterInSection:) implementation:(IMP)UI7TableViewDelegateHeightForFooterInSection types:@"f16@0:4@8i12"];
            }
        }
    }
    [self __setDelegate:delegate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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


@interface UITableViewCell (Patch)

// backup
- (id)__initWithCoder:(NSCoder *)aDecoder;
- (id)__initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


@implementation UITableViewCell (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier { assert(NO); return nil; }

- (void)_tableViewCellInit {
    self.textLabel.font = [UI7Font systemFontOfSize:18.0 attribute:UI7FontAttributeLight];
    self.detailTextLabel.font = [UI7Font systemFontOfSize:17.0 attribute:UI7FontAttributeLight]; // FIXME: not sure
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor; // FIXME: not sure
    self.selectedBackgroundView = [UIColor colorWith8bitWhite:217 alpha:255].image.view;
}

@end


@implementation UI7TableViewCell

+ (void)initialize {
    if (self == [UI7TableViewCell class]) {
        Class target = [UITableViewCell class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithStyle:reuseIdentifier:) fromSelector:@selector(initWithStyle:reuseIdentifier:)];
    }
}

+ (void)patch {
    Class target = [UITableViewCell class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithStyle:reuseIdentifier:) toClass:target];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _tableViewCellInit];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self __initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self _tableViewCellInit];
    }
    return self;
}

@end
