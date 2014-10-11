//
//  DetailViewController+networking.m
//  StageManager
//
//  Created by Michal Ziman on 6/5/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "DetailViewController+networking.h"
#import "MovableViewController.h"
#import "ImageHelper.h"

//#define CONNECTION_SIMULATOR

@implementation DetailViewController (networking)

- (void)viewWillDisappear:(BOOL)animated
{
    // unlock
    [self.panGesture setEnabled:YES];
    
    selectionsDisabled = NO;
    selectingMyInstrument = NO;
    [self deselectInstrument];
    [myInstrument.view setAlpha:1.0f];
    myInstrument = nil;
    isButtonsControllerrEnabled = YES;
    [self.navigationItem setTitle:@""];
//    [self.master.tableView setHidden:NO]; // @TODO uncomment later
    [self.master.navigationController popViewControllerAnimated:YES];
    [self.connectionButton setTitle: @"Stage Publishing" forState:UIControlStateNormal];
    if (publishingServer) {
        [publishingServer endSession];
    }
    if (publishingClient) {
        
        [publishingClient disconnectFromServer];
    }
}

#pragma mark - Server and Client delegate methods

- (void)server:(Server *)server clientDidConnect:(NSString *)peerID
{
    [publishingServer sendMessage:[NSString stringWithFormat:@"Instruments:_%d",instrumentsViewControllers.count] toPeer:peerID];
}
- (void)server:(Server *)server clientDidDisconnect:(NSString *)peerID
{
    // zatial netreba riesti
}
- (void)serverSessionDidEnd:(Server *)server
{
//    [[[UIAlertView alloc] initWithTitle:@"Publishing stopped" message:@"Server ended session." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self viewWillDisappear:NO];
    
}
- (void)serverNoNetwork:(Server *)server
{
    [[[UIAlertView alloc] initWithTitle:@"No network" message:@"No network has been found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self viewWillDisappear:NO];
}
- (void)server:(Server *)server didReceiveMessage:(NSString *)message fromClient:(NSString *)peerID
{
#ifdef DEBUG
    NSLog(@"Message received: %@",message);
#endif
    if ([message isEqualToString:@"Send"]) {
        [self sendInstruments:peerID];
    } else {
        NSArray *components = [message componentsSeparatedByString:@"_"];
        MovableViewController *a, *b;
        BOOL volumeUp = [[components objectAtIndex:11] boolValue];
        
        NSString *title = [components objectAtIndex:1];
        CGRect r, r2;
        r.origin.x = [[components objectAtIndex:2] intValue];
        r.origin.y = [[components objectAtIndex:3] intValue];
        r.size.width = [[components objectAtIndex:4] intValue];
        r.size.height = [[components objectAtIndex:5] intValue];
        
        NSString *title2 = [components objectAtIndex:6];
        r2.origin.x = [[components objectAtIndex:7] intValue];
        r2.origin.y = [[components objectAtIndex:8] intValue];
        r2.size.width = [[components objectAtIndex:9] intValue];
        r2.size.height = [[components objectAtIndex:10] intValue];
        
        // simple solution for cases where correct objects cant be found ... pass incorect
        a = [instrumentsViewControllers objectAtIndex:0];
        b = [instrumentsViewControllers objectAtIndex:1];
        
        for (MovableViewController *instrument in instrumentsViewControllers) {
            if ([instrument.title isEqualToString:title]) {
                CGRect f = instrument.view.frame;
                if ((int)f.origin.x==(int)r.origin.x && (int)f.origin.y==(int)r.origin.y) {
                    if ((int)f.size.width==(int)r.size.width && (int)f.size.height==(int)r.size.height) {
                        a = instrument;
                    }
                }
            }
            if ([instrument.title isEqualToString:title2]) {
                CGRect f = instrument.view.frame;
                if ((int)f.origin.x==(int)r2.origin.x && (int)f.origin.y==(int)r2.origin.y) {
                    if ((int)f.size.width==(int)r2.size.width && (int)f.size.height==(int)r2.size.height) {
                        b = instrument;
                    }
                }
            }
        } // end for
        
        [self didReceiveNotificationFromClient:volumeUp from:a to:b];
    }
}

- (void)sendInstruments:(NSString *)peerID
{
    int index = 0;
    for (MovableViewController *instrument in instrumentsViewControllers) {
        CGPoint o = instrument.view.frame.origin;
        CGSize s = instrument.view.frame.size;
        NSString *imgName = instrument.image.imageName;
        int x = (int)o.x, y = (int)o.y, w =(int)s.width, h = (int)s.height;
        NSString *message = [NSString stringWithFormat:@"Instrument:_%@_%@_%d_%d_%d_%d_%d", instrument.title, imgName, x,y,w,h,index];
        [publishingServer sendMessage:message toPeer:peerID];
#ifdef DEBUG
        NSLog(@"Server sent instrument %@_%@_%d_%d_%d_%d_%d to peer %@",instrument.title, imgName, x,y,w,h,index, peerID);
#endif
        index++;
    }
}

#pragma mark - Client

- (void)client:(Client *)client serverBecameAvailable:(NSString *)peerID
{
#ifdef DEBUG
    NSLog(@"Client connected");
#endif
    [client connectToServerWithPeerID:peerID];
    [self.navigationItem setTitle:@"Connected"];
}
- (void)client:(Client *)client serverBecameUnavailable:(NSString *)peerID
{
#ifdef DEBUG
    NSLog(@"Client disconnected");
#endif
    [client disconnectFromServer];
    // netreba
}
- (void)client:(Client *)client didDisconnectFromServer:(NSString *)peerID
{
//    [[[UIAlertView alloc] initWithTitle:@"Disconnected" message:@"You were disconnected from server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self viewWillDisappear:NO];
}
- (void)clientNoNetwork:(Client *)client
{
    [[[UIAlertView alloc] initWithTitle:@"No network" message:@"No network has been found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self viewWillDisappear:NO];
}
- (void)client:(Client *)client didConnectToServer:(NSString *)peerID
{
    // netreba implementovat
}
- (void)client:(Client *)client didReceiveMessage:(NSString *)message
{
#ifdef DEBUG
    NSLog(@"Message received: %@",message);
#endif
    NSArray *components = [message componentsSeparatedByString:@"_"];
    if ([[components objectAtIndex:0] isEqualToString:@"Instruments:"]) {
        int capacity = [[components objectAtIndex:1] intValue];
        instrumentMessages = [[NSMutableArray alloc] initWithCapacity:capacity];
        instrumentMessagesNumber = capacity;
        [publishingClient sendMessage:@"Send"];
    }
    
    if ([[components objectAtIndex:0] isEqualToString:@"Instrument:"]) {
        int index = [[components objectAtIndex:7] intValue];
        [instrumentMessages insertObject:message atIndex:index];
        instrumentMessagesNumber--;
        if (instrumentMessagesNumber<=0) {
            for (NSString *message in instrumentMessages) {
                [self addInstrumentFromMessage:message];
            }
            selectingMyInstrument = YES;
        }
    }
    
    
}

-(void)addInstrumentFromMessage:(NSString*)message
{
#ifdef DEBUG
    NSLog(@"Adding received: %@",message);
#endif
    NSArray *components = [message componentsSeparatedByString:@"_"];
    int x = [[components objectAtIndex:3] intValue];
    int y = [[components objectAtIndex:4] intValue];
    int w = [[components objectAtIndex:5] intValue];
    int h = [[components objectAtIndex:6] intValue];
    
    CGRect frame = CGRectMake(x, y, w, h);
    
    NSString *title = [components objectAtIndex:1];
    NSString *imgName = [components objectAtIndex:2];
    
    Image *image = [[Image alloc] initWithTitle:title andImageName:imgName];
    NSMutableString* imageURL = [[NSMutableString alloc] initWithString:image.imageName];
    [imageURL appendString:@".png"];
    image.image = [UIImage imageNamed:imageURL];
    
    NSMutableString* imageMenuURL = [[NSMutableString alloc] initWithString:image.imageName];
    [imageMenuURL appendString:@"-menu.png"];
    image.menuIcon = [UIImage imageNamed:imageMenuURL];
    
    // copied from addInstrument and modified
    MovableViewController *movableViewController = [[MovableViewController alloc] init];
    movableViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MovableViewController"];
    movableViewController.title = image.title;
    movableViewController.image = image;
    movableViewController.sender = self;
    UIImageView *view = (UIImageView*)movableViewController.view;
    [view setFrame:frame];
    if(!instrumentsViewControllers) {
        instrumentsViewControllers = [[NSMutableArray alloc] init];
    }
    [instrumentsViewControllers addObject:movableViewController];
    [self.view addSubview: view];
}

#pragma mark - User action concerning networking

- (IBAction)connectionButtonPressed:(id)sender
{
#ifdef DEBUG
    NSLog(@"Connection button pressed");
#endif
    if ([self.connectionButton.titleLabel.text isEqualToString:@"Disconnect"])
    {
        [self viewWillDisappear:NO]; // iba vyuzivam existujucu metodu, aby som nemusel kopirovat kod
        // v skutocnosti to nema so zmiznutim viewu nic spolocne
        // odpoji klienta, vypne server
        return;
    }
    
    
    if (self.networkConnectionView.isHidden) {
        [self.networkConnectionView setHidden:NO];
//        [self.master.tableView setHidden:YES]; // @TODO uncomment later
        [self.master performSegueWithIdentifier:@"hide" sender:self];
        
    } else {
        [self.networkConnectionView setHidden:YES];
//        [self.master.tableView setHidden:NO]; // @TODO uncomment later
        [self.master.navigationController popViewControllerAnimated:YES];
    }
    
    [self deselectInstrument];
    
    [volumeController setDelegate:self];
    [self.view bringSubviewToFront:self.networkConnectionView];
}

- (IBAction)startServer:(id)sender {
    // lock
    [self.panGesture setEnabled:NO];
    
    publishingServer = [Server new];
    [publishingServer setMaxClients:[instrumentsViewControllers count]];
    [publishingServer setDelegate:self];
    sessionName = [NSString stringWithFormat:@"sm %@",self.callSignTextBox.text];
    [publishingServer startAcceptingConnectionsForSessionID:sessionName];
    
    selectionsDisabled = YES;
    isButtonsControllerrEnabled = NO;
    [buttonsController.view setHidden:YES];
    [self.navigationItem setTitle:@"Publishing active"];
    [self.networkConnectionView setHidden:YES];
    [self.connectionButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    
}

- (IBAction)startClient:(id)sender {
    // lock
    [self.panGesture setEnabled:NO];
    
    for (MovableViewController *instrument in instrumentsViewControllers)
    {
        [instrument.view removeFromSuperview];
        [instrument removeFromParentViewController];
    }
    [instrumentsViewControllers removeAllObjects];
    
    publishingClient = [Client new];
    [publishingClient setDelegate:self];
    sessionName = [NSString stringWithFormat:@"sm %@",self.callSignTextBox.text];
    [publishingClient startSearchingForServersWithSessionID:sessionName];
    
    isButtonsControllerrEnabled = NO;
    [buttonsController.view setHidden:YES];
    [self.navigationItem setTitle:@"Searching..."];
    [self.networkConnectionView setHidden:YES];
    [self.connectionButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    // connection simulation
#ifdef CONNECTION_SIMULATOR
    NSLog(@"Simulating connection");
    {
        [self.navigationItem setTitle:@"Connected"];

        int capacity = 4;
        instrumentMessages = [[NSMutableArray alloc] initWithCapacity:capacity];
        instrumentMessagesNumber = capacity;

        
        int index = 0;
        NSString *message = @"Instrument:_Piano_piano_395_308_300_300_0";
        [instrumentMessages insertObject:message atIndex:index];
        instrumentMessagesNumber--;
        if (instrumentMessagesNumber<=0) {
            for (NSString *message in instrumentMessages) {
                [self addInstrumentFromMessage:message];
            }
            selectingMyInstrument = YES;
        }
        
        index = 1;
        message = @"Instrument:_Saxaphone_saxaphone_10_323_200_300_1";
        [instrumentMessages insertObject:message atIndex:index];
        instrumentMessagesNumber--;
        if (instrumentMessagesNumber<=0) {
            for (NSString *message in instrumentMessages) {
                [self addInstrumentFromMessage:message];
            }
            selectingMyInstrument = YES;
        }
        
        index = 2;
        message = @"Instrument:_Classic Guitar_wood-guit-yellow_181_220_140_300_2";
        [instrumentMessages insertObject:message atIndex:index];
        instrumentMessagesNumber--;
        if (instrumentMessagesNumber<=0) {
            for (NSString *message in instrumentMessages) {
                [self addInstrumentFromMessage:message];
            }
            selectingMyInstrument = YES;
        }
        
        index = 3;
        message = @"Instrument:_Microphone_microphone_287_386_130_300_3";
        [instrumentMessages insertObject:message atIndex:index];
        instrumentMessagesNumber--;
        if (instrumentMessagesNumber<=0) {
            for (NSString *message in instrumentMessages) {
                [self addInstrumentFromMessage:message];
            }
            selectingMyInstrument = YES;
        }
        
    }
#endif
    
    
}

- (void)sendMessageToServer:(BOOL)volumUp from:(MovableViewController *)a to:(MovableViewController *)b
{
    NSMutableString *message = [NSMutableString stringWithFormat:@"VolumeRequest:_%@_",a.title];
    CGRect f = a.view.frame;
    [message appendFormat:@"%d_%d_%d_%d_",(int)f.origin.x,(int)f.origin.y,(int)f.size.width,(int)f.size.height];
    [message appendFormat:@"%@_",b.title];
    f = b.view.frame;
    [message appendFormat:@"%d_%d_%d_%d_",(int)f.origin.x,(int)f.origin.y,(int)f.size.width,(int)f.size.height];
    
    [message appendFormat:@"%d",(int)volumUp];
    
    [publishingClient sendMessage:message];
}

#pragma mark - VolumeControllerDelegate

-(void)volumeChangeRequested:(BOOL)increase
{
#ifdef DEBUG
    NSLog(@"Calling volume change request");
#endif
    [self sendMessageToServer:increase from:myInstrument to:selectedInstrumentController];
}

@end
