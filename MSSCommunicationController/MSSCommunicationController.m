//
//  MSSCommunicationController.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "MSSCommunicationController.h"
#import "MSSCContactDescriptor.h"
#import <ifaddrs.h>
#import <arpa/inet.h>


@implementation MSSCommunicationController

@synthesize contactDictionary = _contacDescriptorsDictionaty;
@synthesize deviceDictionary = _deviceInformationsDictionary;
@synthesize delegate = _delegate;


+ (id) sharedController
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(MSSCommunicationController *) init{
    
    
    self = [super init];
    
    if(self){
        
        udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    return self;
    
}

-(void) connectToHost:(NSString *)host onPort:(uint16_t) port{
    
    NSError* error = nil;
    
    [udpSocket connectToHost:host onPort:port error:&error];
    
}

-(void) sendData:(NSData *) data{
    
    
    [udpSocket sendData:data withTimeout:-1 tag:0];
}

-(void) getContacsFromCodeine{
    
    NSData* data;
    NSError* error = nil;
    
    CodeineMessageContacts*  cmC = [CodeineMessageContacts messageOfTypeGet];
    
    data = [cmC data];
    [self sendData: data];
    [udpSocket beginReceiving:&error];
}

-(void) getDevicesFromCodeine{
    
    NSData* data;
    NSError* error = nil;
    
    CodeineMessageIPs*  cmIPs = [CodeineMessageIPs messageOfTypeGet];
    
    data = [cmIPs data];
    [self sendData: data];
    [udpSocket beginReceiving:&error];

}

-(void) setDeviceToCodeine:(DeviceInformation *)thisDeviceInformation{

    NSData* data;
    NSError* error = nil;
    
    NSArray* array = [NSArray arrayWithObject:thisDeviceInformation];
    
    PackedDeviceInformations* pdi = [PackedDeviceInformations packedDeviceInformationsWithDIArray:array];
    
    CodeineMessageIPs*  cmIPs = [CodeineMessageIPs messageOfTypeSetWithPDI:pdi];
    
    data = [cmIPs data];
    [self sendData:data];
    [udpSocket beginReceiving:&error];

}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    
    CodeineMessage* cM;
    
    cM = [CodeineMessage messageFromData:data];
    
    if(cM.msgType == kMSGContacts){
        if(cM.subType == kMSGSetContacts){
        
            CodeineMessageContacts* cMC = [CodeineMessageContacts messageFromData:data];
            
            [self hasContactData:cMC.pcd];
        }
    }
    
    if (cM.msgType == kMSGIPs) {
        if(cM.subType == kMSGSetIPs){
        
            CodeineMessageIPs* cMIPs = [CodeineMessageIPs messageFromData:data];
            [self hasIPData:cMIPs.pdi];
        }
    }
    
    
    
    
}

-(void) hasContactData:(PackedContacDescriptors *)pcd {

    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    for (int i; i< pcd.count; i++) {
        
        MSSCContactDescriptor* d = [pcd.contacs objectAtIndex:i];
        
        [dictionary setObject:d forKey:[NSNumber numberWithUnsignedChar:d.byteValue]];
    }
    
    self.contactDictionary = dictionary;
    
    if([_delegate conformsToProtocol:@protocol(MSSCommunicationProtocol)]){
        
        
        [_delegate newContacs:self.contactDictionary];
    }

}

-(void) hasIPData:(PackedDeviceInformations *)pdi {

    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    for (int i; i< pdi.count; i++) {
        
        MSSCContactDescriptor* d = [pdi.devices objectAtIndex:i];
        
        [dictionary setObject:d forKey:[NSNumber numberWithUnsignedChar:d.byteValue]];
    }
    
    self.deviceDictionary = dictionary;
    
    if([_delegate conformsToProtocol:@protocol(MSSCommunicationProtocol)]){
        
        
        [_delegate newIPs:self.deviceDictionary];
    }

}


#pragma mark -
#pragma mark Class Utilities

+ (NSString *) deviceIp{
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0){
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL){
            if(temp_addr->ifa_addr->sa_family == AF_INET){
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]){
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
@end
