//
//  UITSubviewTableViewController.m
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 5. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UITSubviewTableViewController.h"

@interface UITSubviewTableViewController ()

@end

@implementation UITSubviewTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        views = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        views = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)edit:(id)sender {
    [self->tableView setEditing:!self->tableView.editing animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];

    for (id x in @[@1, @2, @3]) {
        UILabel *aLabel = [[[UILabel alloc] initWithFrame:CGRectMake(.0, .0, 320.0, 40.0)] autorelease];
        aLabel.text = @"TextLabel";

        [views addObject:aLabel];

        UITextView *aTextView = [[[UITextView alloc] initWithFrame:CGRectMake(.0, .0, 320.0, 100.0)] autorelease];
        aTextView.text = @"Hi. This is Text View\nReally?";

        [views addObject:aTextView];

        UIImage *image = [UIImage imageNamed:@"Default"];
        image = [image imageByResizingToSize:CGSizeMake(250.0, 30.0)];
        UIImageView *anImageView = [[[UIImageView alloc] initWithImage:image] autorelease];

        [views addObject:anImageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)subviewTableViewNumberOfSubviews:(UIASubviewTableView *)scrollView {
    
    return self->views.count;
}

- (UIView *)subviewTableView:(UIASubviewTableView *)scrollView viewForRow:(NSUInteger)row {
    return self->views[row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self->views moveObjectAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

@end
