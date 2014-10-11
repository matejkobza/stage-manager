//
//  ButtonsViewController.m
//  StageManager
//
//  Created by Matej Kobza on 6/5/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "ButtonsViewController.h"

@interface ButtonsViewController ()

@end

@implementation ButtonsViewController

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

- (IBAction)buttonPressed:(id)sender
{
#ifdef DEBUG
    NSLog(@"ButtonViewController#buttonPressed");
#endif
    if([sender class] == [UIButton class]) {
        [self.delegate buttonClicked:(UIButton*)sender inView:self.view];
    }
}

@end
