//
//  UITIssue68ViewController.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 9. 22..
//  Copyright (c) 2013년 youknowone.org. All rights reserved.
//

#import "UITIssue68ViewController.h"

@interface UITIssue68ViewController ()

@end

@implementation UITIssue68ViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"Search result";
    return cell;
}

@end
