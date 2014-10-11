//
//  MasterViewController.h
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
