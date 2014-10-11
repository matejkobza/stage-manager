//
//  Client.h
//  simpleGKNetworking
//
//  Created by Michal Ziman on 5/3/13.
//  Copyright (c) 2013 Michal Ziman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@class Client;

@protocol ClientDelegate <NSObject>

- (void)client:(Client *)client serverBecameAvailable:(NSString *)peerID;
- (void)client:(Client *)client serverBecameUnavailable:(NSString *)peerID;
- (void)client:(Client *)client didDisconnectFromServer:(NSString *)peerID;
- (void)clientNoNetwork:(Client *)client;
- (void)client:(Client *)client didConnectToServer:(NSString *)peerID;
- (void)client:(Client *)client didReceiveMessage:(NSString *)message;

@end

@interface Client : NSObject <GKSessionDelegate>

@property (nonatomic, strong, readonly) NSArray *availableServers;
@property (nonatomic, strong, readonly) GKSession *session;
@property (nonatomic, weak) id <ClientDelegate> delegate;

- (void)startSearchingForServersWithSessionID:(NSString *)sessionID;
- (NSUInteger)availableServerCount;
- (NSString *)peerIDForAvailableServerAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;
- (void)connectToServerWithPeerID:(NSString *)peerID;
- (void)sendMessage:(NSString *)message; // to server
- (void)disconnectFromServer;

@end
