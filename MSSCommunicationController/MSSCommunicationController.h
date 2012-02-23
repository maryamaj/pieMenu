//
//  MSSCommunicationController.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "CodeineStructs.h"

@interface MSSCommunicationController : NSObject <GCDAsyncUdpSocketDelegate>
{
    
    GCDAsyncUdpSocket *udpSocket;
    
}

+ (id)sharedController;
- (MSSCommunicationController *) init;
-(void) hasData:(PackedContactDescriptors *) pcd;
-(void) connectToHost:(NSString *)host onPort:(uint16_t) port;
-(void) sendData:(NSData *) data;
-(void) handshake;

@end
