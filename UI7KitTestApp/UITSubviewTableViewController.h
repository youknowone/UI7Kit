//
//  UITSubviewTableViewController.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 5. 11..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

@interface UITSubviewTableViewController : UIViewController<UIASubviewTableSubviewSource, UITableViewDelegate> {
    IBOutlet UIASubviewTableView *tableView;
    NSMutableArray *views;
}

@end
