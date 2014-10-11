//
//  ServerNotificationsViewController.h
//  StageManager
//
//  Created by Matej Kobza on 6/6/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ServerNotificationsViewController;

@protocol ServerNotificationDelegate <NSObject>

- (void)notificationAccepted:(ServerNotificationsViewController *)sender;

@end

@interface ServerNotificationsViewController : UIViewController

@property (nonatomic, weak) id <ServerNotificationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *button;

-(IBAction)accepted:(id)sender;


@end
