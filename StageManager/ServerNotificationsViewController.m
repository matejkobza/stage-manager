//
//  ServerNotificationsViewController.m
//  StageManager
//
//  Created by Matej Kobza on 6/6/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "ServerNotificationsViewController.h"

@interface ServerNotificationsViewController ()

@end

@implementation ServerNotificationsViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)accepted:(id)sender
{
    
    [self.delegate notificationAccepted:self];
}

@end
