//
//  DetailViewController+networking.h
//  StageManager
//
//  Created by Michal Ziman on 6/5/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (networking) <ServerDelegate, ClientDelegate, VolumeViewControllerDelegate>

- (IBAction)connectionButtonPressed:(id)sender;
- (IBAction)startServer:(id)sender;
- (IBAction)startClient:(id)sender;

- (void)sendMessageToServer:(BOOL)volumUp from:(MovableViewController *)a to:(MovableViewController *)b;

@end
