//
//  UI7KitTests.m
//  UI7KitTests
//
//  Created by Jeong YunWon on 13. 6. 13..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

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

- (void)testTypeEncoding
{
    Class class = [TableViewDelegate class];
    STAssertEqualObjects([class methodForSelector:@selector(tableView:heightForHeaderInSection:)].typeEncoding, @"f16@0:4@8i12", @"");
    STAssertEqualObjects([class methodForSelector:@selector(tableView:viewForHeaderInSection:)].typeEncoding, @"@16@0:4@8i12", @"");
}

@end
