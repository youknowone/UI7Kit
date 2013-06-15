//
//  UI7TableView.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "NSAClass.h"

#import "UI7TableView.h"

@implementation UITableView (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (id)__initWithFrame:(CGRect)frame { assert(NO); return nil; }
- (void)__setDelegate:(id<UITableViewDelegate>)delegate { assert(NO); return; }

- (void)_tableViewInit {
    //    self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
}

@end


@implementation UI7TableView

// TODO: implement 'setAccessoryType' to fake accessories.

+ (void)initialize {
    if (self == [UI7TableView class]) {
        NSAClass *class = [NSAClass classWithClass:[UITableView class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
        [class copyToSelector:@selector(__setDelegate:) fromSelector:@selector(setDelegate:)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];
    Class targetClass = [UITableView class];
    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass];
    [sourceClass exportSelector:@selector(initWithFrame:) toClass:targetClass];
    [sourceClass exportSelector:@selector(setDelegate:) toClass:targetClass];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self) {
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

CGFloat UI7TableViewDelegateHeightForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    if (title) {
        return tableView.sectionHeaderHeight;
    }
    return .0;
}

CGFloat UI7TableViewDelegateHeightForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title) {
        return tableView.sectionFooterHeight;
    }
    return .0;
}

UIView *UI7TableViewDelegateViewForHeaderInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    CGFloat height = [tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)] ? [tableView.delegate tableView:tableView heightForHeaderInSection:section] : tableView.sectionHeaderHeight;
    NSString *title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];;
    }
    
    UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
    view.backgroundColor = [UIColor iOS7BackgroundColor];

    view.text = [@"    " stringByAppendingString:title];
    view.font = [UIFont iOS7SystemFontOfSize:14.0 weight:UI7FontWeightBold];
    return view;
}

UIView *UI7TableViewDelegateViewForFooterInSection(id self, SEL _cmd, UITableView *tableView, NSUInteger section) {
    CGFloat height = [tableView.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)] ? [tableView.delegate tableView:tableView heightForFooterInSection:section] : tableView.sectionFooterHeight;
    NSString *title = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
    if (title == nil) {
        return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    }
    
    UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(.0, .0, tableView.frame.size.width, height)] autorelease];
    view.backgroundColor = [UIColor iOS7BackgroundColor];
    view.text = [@"    " stringByAppendingString:title]; // TODO: do this pretty later
    view.font = [UIFont iOS7SystemFontOfSize:14.0 weight:UI7FontWeightBold];
    return view;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (self.delegate) {
        NSAClass *delegateClass = [(NSObject *)self.delegate classObject];
        if ([delegateClass methodImplementationForSelector:@selector(tableView:viewForHeaderInSection:)] == (IMP)UI7TableViewDelegateViewForHeaderInSection) {
            // TODO: probably we should remove this methods.
            //            class_removeMethods(￼, ￼)
        }
    }
    if (delegate) {
        NSAClass *delegateClass = [(NSObject *)delegate classObject];
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)] && ![delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            [delegateClass addMethodForSelector:@selector(tableView:viewForHeaderInSection:) implementation:(IMP)UI7TableViewDelegateViewForHeaderInSection types:@"@16@0:4@8i12"];
            if (![delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
                [delegateClass addMethodForSelector:@selector(tableView:heightForHeaderInSection:) implementation:(IMP)UI7TableViewDelegateHeightForHeaderInSection types:@"f16@0:4@8i12"];
            }
        }
        if ([self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)] && ![delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            [delegateClass addMethodForSelector:@selector(tableView:viewForFooterInSection:) implementation:(IMP)UI7TableViewDelegateViewForFooterInSection types:@"@16@0:4@8i12"];
            if (![delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                [delegateClass addMethodForSelector:@selector(tableView:heightForFooterInSection:) implementation:(IMP)UI7TableViewDelegateHeightForHeaderInSection types:@"f16@0:4@8i12"];
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
    self.textLabel.font = [UIFont iOS7SystemFontOfSize:18.0 weight:UI7FontWeightLight];
    self.detailTextLabel.font = [UIFont iOS7SystemFontOfSize:17.0 weight:UI7FontWeightLight]; // FIXME: not sure
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor; // FIXME: not sure
    self.selectedBackgroundView = [UIImage imageNamed:@"UI7TableViewCellSelection"].view; // 
}

@end


@implementation UI7TableViewCell

+ (void)initialize {
    if (self == [UI7TableViewCell class]) {
        NSAClass *class = [NSAClass classWithClass:[UITableViewCell class]];
        [class copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [class copyToSelector:@selector(__initWithStyle:reuseIdentifier:) fromSelector:@selector(initWithStyle:reuseIdentifier:)];
    }
}

+ (void)patch {
    NSAClass *sourceClass = [NSAClass classWithClass:[self class]];
    Class targetClass = [UITableViewCell class];

    [sourceClass exportSelector:@selector(initWithCoder:) toClass:targetClass];
    [sourceClass exportSelector:@selector(initWithStyle:reuseIdentifier:) toClass:targetClass];
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
