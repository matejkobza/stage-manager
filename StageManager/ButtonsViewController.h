//
//  ButtonsViewController.h
//  StageManager
//
//  Created by Matej Kobza on 6/5/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonsViewDelegate.h"

@interface ButtonsViewController : UIViewController

@property (strong, nonatomic) id<ButtonsViewDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;
@end
