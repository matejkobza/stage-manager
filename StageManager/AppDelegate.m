//
//  AppDelegate.m
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "AppDelegate.h"

//static NSString * kWiTapBonjourType = @"_stageManagerConnection._tcp.";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    
    
    //vytvori server s dynamicky prirazenym porterm
    //self.server = [[QServer alloc] initWithDomain:@"local." type:kWiTapBonjourType name:nil preferredPort:0];
    //[self.server setDelegate:self];
    //[self.server start];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//#pragma mark - Connection management
//
//- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
//{
//#pragma unused(stream)
//    
//    switch(eventCode) {
//            
//        case NSStreamEventOpenCompleted: {
//            self.streamOpenCount += 1;
//            assert(self.streamOpenCount <= 2);
//            
//            // Once both streams are open we hide the picker and the game is on.
//            
//            if (self.streamOpenCount == 2) {
////                [self dismissPicker];
//                
//                //[self.server deregister];
//            }
//        } break;
//            
//        case NSStreamEventHasSpaceAvailable: {
//            assert(stream == self.outputStream);
//            // do nothing
//        } break;
//            
//        case NSStreamEventHasBytesAvailable: {
//            uint8_t     b;
//            NSInteger   bytesRead;
//            
//            assert(stream == self.inputStream);
//            
//            bytesRead = [self.inputStream read:&b maxLength:sizeof(uint8_t)];
//            if (bytesRead <= 0) {
//                // Do nothing; we'll handle EOF and error in the
//                // NSStreamEventEndEncountered and NSStreamEventErrorOccurred case,
//                // respectively.
//            } else {
//                // We received a remote tap update, forward it to the appropriate view
////                if ( (b >= 'A') && (b < ('A' + kTapViewControllerTapItemCount))) {
////                    [self.tapViewController remoteTouchDownOnItem:b - 'A'];
////                } else if ( (b >= 'a') && (b < ('a' + kTapViewControllerTapItemCount))) {
////                    [self.tapViewController remoteTouchUpOnItem:b - 'a'];
////                } else {
////                    // Ignore the bogus input.  This is important because it allows us
////                    // to telnet in to the app in order to test its behaviour.  telnet
////                    // sends all sorts of odd characters, so ignoring them is a good thing.
////                }
//            }
//        } break;
//            
//        default:
//            assert(NO);
//            // fall through
//        case NSStreamEventErrorOccurred:
//            // fall through
//        case NSStreamEventEndEncountered: {
////            [self setupForNewGame];
//        } break;
//    }
//}
//
//
//#pragma mark - Help methods for network streaming
//
//- (void)openStreams
//{
//    assert(self.inputStream != nil);            // streams must exist but aren't open
//    assert(self.outputStream != nil);
//    assert(self.streamOpenCount == 0);
//    
////    [self.inputStream  setDelegate:self];
////    [self.inputStream  scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
////    [self.inputStream  open];
//    
////    [self.outputStream setDelegate:self];
////    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
////    [self.outputStream open];
//}
//
//- (void)closeStreams
//{
//    assert( (self.inputStream != nil) == (self.outputStream != nil) );      // should either have both or neither
//    if (self.inputStream != nil) {
////        [self.server closeOneConnection:self];
//        
//        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [self.inputStream close];
//        self.inputStream = nil;
//        
//        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [self.outputStream close];
//        self.outputStream = nil;
//    }
//    self.streamOpenCount = 0;
//}
//
//
//#pragma mark - QServer delegate
//
////- (void)serverDidStart:(QServer *)server
////{
//
////}
//
////- (id)server:(QServer *)server connectionForInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream
////{
////    id  result;
////
////    assert(server == self.server);
////    #pragma unused(server)
////    assert(inputStream != nil);
////    assert(outputStream != nil);
////
////    assert( (self.inputStream != nil) == (self.outputStream != nil) );      // should either have both or neither
////
////    if (self.inputStream != nil) {
////        // We already have a game in place; reject this new one.
//        result = nil;
//    } else {
//        // Start up the new game.  Start by deregistering the server, to discourage
//        // other folks from connecting to us (and being disappointed when we reject
//        // the connection).
//        
//        [self.server deregister];
//        
//        // Latch the input and output sterams and kick off an open.
//        
//        self.inputStream  = inputStream;
//        self.outputStream = outputStream;
//        
//        [self openStreams];
//        
//        // This is kinda bogus.  Because we only support a single input stream
//        // we use the app delegate as the connection object.  It makes sense if
//        // you think about it long enough, but it's definitely strange.
//        
//        result = self;
//    }
//    
//    return result;
//}
//
//- (void)server:(QServer *)server didStopWithError:(NSError *)error
//// This is called when the server stops of its own accord.  The only reason
//// that might happen is if the Bonjour registration fails when we reregister
//// the server, and that's hard to trigger because we use auto-rename.  I've
//// left an assert here so that, if this does happen, we can figure out why it
//// happens and then decide how best to handle it.
//{
//    assert(server == self.server);
//    #pragma unused(server)
//    #pragma unused(error)
//    assert(NO);
//}
//
//- (void)server:(QServer *)server closeConnection:(id)connection
//{
//    // This is called when the server shuts down, which currently never happens.
//    assert(server == self.server);
//    #pragma unused(server)
//    #pragma unused(connection)
//    assert(NO);
//}

@end
