//
//  VolumeViewController.h
//  StageManager
//
//  Created by Matej Kobza on 6/6/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VolumeViewControllerDelegate <NSObject>

- (void)volumeChangeRequested:(BOOL)increase;

@end

@interface VolumeViewController : UIViewController
@property (nonatomic, weak) id <VolumeViewControllerDelegate> delegate;

-(IBAction)volumeUp:(id)sender;
-(IBAction)volumeDown:(id)sender;

@end
