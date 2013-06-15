//
//  UITPreparedCellTableViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 4. 7..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITPreparedCellTableViewController.h"

@interface UITPreparedCellTableViewController ()

@end

@implementation UITPreparedCellTableViewController

@synthesize tableView=_tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *titles = @[@"title1", @"title2", @"title3"];
    self.tableView.hasUniqueSection = YES;
    self.tableView.cells = [titles arrayByMappingOperatorWithIndex:^id(id obj, NSUInteger index) {
        UITableViewCell *cell = [UITableViewCell cellWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = obj;
        cell.detailTextLabel.text = [NSString stringWithInteger:index];
        return cell;
    }];
    assert([self.tableView.cells[0] isKindOfClass:[UITableViewCell class]]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"hi");
}

@end
