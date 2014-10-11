//
//  Server.h
//  simpleGKNetworking
//
//  Created by Michal Ziman on 5/3/13.
//  Copyright (c) 2013 Michal Ziman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@class Server;

@protocol ServerDelegate <NSObject>

- (void)server:(Server *)server clientDidConnect:(NSString *)peerID;
- (void)server:(Server *)server clientDidDisconnect:(NSString *)peerID;
- (void)serverSessionDidEnd:(Server *)server;
- (void)serverNoNetwork:(Server *)server;
- (void)server:(Server *)server didReceiveMessage:(NSString *)message fromClient:(NSString *)peerID;

@end

@interface Server : NSObject <GKSessionDelegate>

@property (nonatomic, assign) int maxClients;
@property (nonatomic, strong) GKSession *session;
@property (nonatomic, weak) id <ServerDelegate> delegate;

- (void)endSession;
- (void)startAcceptingConnectionsForSessionID:(NSString *)sessionID;
- (NSUInteger)connectedClientCount;
- (NSString *)peerIDForConnectedClientAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;
- (void)sendMessage:(NSString *)message toPeer:(NSString *)peerID;
- (void)sendMessageToConnectedPeers:(NSString *)message;
- (void)stopAcceptingConnections;

@end