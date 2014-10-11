//
//  AppDelegate.h
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "QServer.h"

//@interface AppDelegate : UIResponder <UIApplicationDelegate,QServerDelegate,NSStreamDelegate>
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong, readwrite) QServer *              server;
@property (nonatomic, strong, readwrite) NSInputStream *        inputStream;
@property (nonatomic, strong, readwrite) NSOutputStream *       outputStream;
@property (nonatomic, assign, readwrite) NSUInteger             streamOpenCount;

@end
