//
//  UICBareTableViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 7. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UICBareTableViewController.h"

@interface UICBareTableViewController ()

@end

@implementation UICBareTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [UITableViewCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [@"Generated Cell #%dx%d" format0:nil, indexPath.section, indexPath.row];
    return cell;
}

@end
