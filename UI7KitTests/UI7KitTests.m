//
//  UI7KitTests.m
//  UI7KitTests
//
//  Created by Jeong YunWon on 13. 6. 13..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7KitTests.h"

@interface TableViewDelegate : NSObject<UITableViewDelegate>

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
    NSAClass *class = [TableViewDelegate classObject];
    STAssertEqualObjects([class methodObjectForSelector:@selector(tableView:heightForHeaderInSection:)].typeEncoding, @"f16@0:4@8i12", @"");
    STAssertEqualObjects([class methodObjectForSelector:@selector(tableView:viewForHeaderInSection:)].typeEncoding, @"@16@0:4@8i12", @"");
}

@end
