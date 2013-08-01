//
//  UI7TableView.h
//  FoundationExtension
//
//  Created by Jeong YunWon on 13. 6. 12..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import "UI7Utilities.h"

@interface UITableView (UI7Kit)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
#endif

@end

@interface UI7TableView : UITableView<UI7Patch>

@end



@interface UI7TableViewController : UITableViewController

@end
