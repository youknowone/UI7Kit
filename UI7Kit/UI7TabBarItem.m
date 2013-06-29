//
//  UI7TabBarItem.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 16..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7TabBarItem.h"

@interface UITabBarItem (Private)

@property(nonatomic,retain) UIImage * selectedImage;
@property(nonatomic,retain) UIImage * unselectedImage __deprecated; // rejected

@property(nonatomic,readonly) BOOL isSystemItem;
@property(nonatomic,readonly) UITabBarSystemItem systemItem;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)_updateImageWithTintColor:(UIColor *)tintColor isSelected:(BOOL)selected getImageOffset:(UIOffset *)offset;

@end


@implementation UITabBarItem (Patch)

- (id)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }

- (void)_tabBarItemInit {

}

@end


@implementation UI7TabBarItem

+ (void)initialize {
    if (self == [UI7TabBarItem class]) {
        Class origin = [UITabBarItem class];

        [origin copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
    }
}

+ (void)patch {
    Class source = [self class];
    Class target = [UITabBarItem class];

    [source exportSelector:@selector(initWithCoder:) toClass:target];
    [source exportSelector:@selector(_updateImageWithTintColor:isSelected:getImageOffset:) toClass:target];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag {
    self = [super initWithTitle:title image:image tag:tag];
    [self _tabBarItemInit];
    return self;
}

- (id)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag {
    self = [super initWithTabBarSystemItem:systemItem tag:tag];
    [self _tabBarItemInit];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        if (self.isSystemItem) {
            // TODO: not easy...
        }
        [self _tabBarItemInit];
        self.selectedImage = [UIImage clearImage];
    }
    return self;
}

- (id)_updateImageWithTintColor:(UIColor *)tintColor isSelected:(BOOL)selected getImageOffset:(UIOffset *)offset {
    UIImage *image = [self.image imageByFilledWithColor:tintColor];
    if (image == nil) return nil;

    if (selected) {
        self.selectedImage = image;
    } else {
        NSString *name = [@"_set" stringByAppendingString:@"UnselectedImage:"];
        SEL selector = NSSelectorFromString(name);
        IMP impl = class_getMethodImplementation(self.class, selector);
        impl(self, _cmd, image);
    }
    return image;
}


@end
