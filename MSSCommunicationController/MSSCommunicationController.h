//
//  MSSCommunicationController.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "CodeineMessageContacts.h"
#import "CodeineMessageIPs.h"


@protocol MSSCommunicationProtocol <NSObject>

@required

-(void) newContacs:(NSDictionary *) contacDictionary;

@optional

-(void) newIPs:(NSDictionary *) ipDictionary;

@end


@interface MSSCommunicationController : NSObject <GCDAsyncUdpSocketDelegate>
{
    
    GCDAsyncUdpSocket *udpSocket;
    NSMutableDictionary *_contacDescriptorsDictionaty;
    NSMutableDictionary *_deviceInformationsDictionary;
    __weak id <MSSCommunicationProtocol> _delegate;
    
}

@property (strong, atomic) NSMutableDictionary* contactDictionary;
@property (strong, atomic) NSMutableDictionary* deviceDictionary;
@property (weak, nonatomic) id <MSSCommunicationProtocol> delegate;

+(id)sharedController;
+ (NSString *) deviceIp;
-(MSSCommunicationController *) init;
-(void) hasContactData:(PackedContacDescriptors *) pcd;
-(void) hasIPData:(PackedDeviceInformations *) pdi;
-(void) connectToHost:(NSString *)host onPort:(uint16_t) port;
-(void) sendData:(NSData *) data;
-(void) getContacsFromCodeine;
-(void) setDeviceToCodeine:(DeviceInformation *) thisDeviceInformation;

@end
