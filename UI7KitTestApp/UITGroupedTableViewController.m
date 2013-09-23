//
//  UITGroupedTableViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 3..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITGroupedTableViewController.h"

@interface UITGroupedTableViewController ()

@end

@implementation UITGroupedTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"title";
}

@end
