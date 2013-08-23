//
//  UI7KitTests.m
//  UI7KitTests
//
//  Created by Jeong YunWon on 13. 6. 13..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Utilities.h"
#import "UI7Button.h"

#import "UI7KitTests.h"

@interface TableViewDelegate : NSObject<UITableViewDelegate, UI7Patch>

@end

@implementation TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return  .0; }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { return nil; }

@end


@implementation UI7KitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTypeEncoding {
    Class class = [TableViewDelegate class];
    STAssertEqualObjects([class methodForSelector:@selector(tableView:heightForHeaderInSection:)].typeEncoding, @"f16@0:4@8i12", @"");
    STAssertEqualObjects([class methodForSelector:@selector(tableView:viewForHeaderInSection:)].typeEncoding, @"@16@0:4@8i12", @"");
}

- (void)testButtonTintColor {
    {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.tintColor = [UIColor redColor];
        UIColor *c = b.tintColor;
        STAssertEqualObjects(c, nil, @"");
        STAssertEquals(b.titleLabel.font.pointSize, [UIFont buttonFontSize], @"");
    }
    {
        UIButton *b = [UI7Button buttonWithType:UIButtonTypeCustom];
        b.tintColor = [UIColor redColor];
        UIColor *c = b.tintColor;
        STAssertEqualObjects(c, nil, @"");
    }
}

- (void)testSystemFontSize {
    STAssertEquals([UIFont buttonFontSize], 18.0f, @"");
    STAssertEquals([UIFont labelFontSize], 17.0f, @"");
    STAssertEquals([UIFont systemFontSize], 14.0f, @"");
    STAssertEquals([UIFont smallSystemFontSize], 12.0f, @"");
}

@end
