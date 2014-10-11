//
//  DetailViewController.h
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Modified by Matej Kobza.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"
#import "Server.h"
#import "Client.h"
#import "ButtonsViewDelegate.h"
#import "MasterViewController.h"
#import "ButtonsViewController.h"
#import "VolumeViewController.h"

@class MovableViewController;


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,UIGestureRecognizerDelegate, ButtonsViewDelegate> {
    ButtonsViewController *buttonsController;
    NSMutableArray *instrumentsViewControllers;
    Server *publishingServer;
    Client *publishingClient;
    NSString *sessionName;
    NSMutableArray *instrumentMessages;
    int instrumentMessagesNumber;
    BOOL isButtonsControllerrEnabled;
    BOOL selectingMyInstrument;
    MovableViewController *myInstrument;
    VolumeViewController *volumeController;
    MovableViewController *selectedInstrumentController;
    BOOL selectionsDisabled;
}


@property (nonatomic, retain) UIPanGestureRecognizer * panGesture;

@property (weak, nonatomic) IBOutlet UIView *networkConnectionView;
@property (weak, nonatomic) IBOutlet UITextField *callSignTextBox;
@property (weak, nonatomic) IBOutlet UIButton *connectionButton;
@property (weak, nonatomic) MasterViewController *master;

-(void) addInstrument:(Image*) instrument;
-(void) selectInstrument:(MovableViewController*) instrumentController;
-(void) deselectInstrument;
-(void) removeInstrument:(MovableViewController*) instrumentController;
-(void) didReceiveNotificationFromClient:(BOOL) volumeUp from:(MovableViewController*)from to:(MovableViewController*)to;

@end
