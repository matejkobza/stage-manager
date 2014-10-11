//
//  VolumeViewController.m
//  StageManager
//
//  Created by Matej Kobza on 6/6/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "VolumeViewController.h"

@interface VolumeViewController ()

@end

@implementation VolumeViewController

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

- (void)volumeUp:(id)sender
{
    [self.delegate volumeChangeRequested:YES];
}

- (void)volumeDown:(id)sender
{
    [self.delegate volumeChangeRequested:NO];
}

@end
