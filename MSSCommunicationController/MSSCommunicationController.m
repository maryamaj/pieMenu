//
//  MSSCommunicationController.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "MSSCommunicationController.h"

@implementation MSSCommunicationController

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

-(void) handshake{
    
    NSData* data;
    NSError* error = nil;
    
    NSString* handshake = [NSString stringWithFormat:@"GET"];
    data = [handshake dataUsingEncoding:NSASCIIStringEncoding];
    
    [self sendData:data];
    [udpSocket beginReceiving:&error];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    
    PackedContactDescriptors *pcd;
    
    pcd = malloc(sizeof(PackedContactDescriptors));
    
    char* bytes =(char *) [data bytes];
    
    pcd->count = bytes[0];
    
    pcd->descArray = malloc(pcd->count * sizeof(ContactDescriptor));
    memcpy(pcd->descArray, (bytes+sizeof(char)), pcd->count*sizeof(ContactDescriptor));
    
    [self hasData:pcd];
    
}

-(void) hasData:(PackedContactDescriptors *) pcd{

    
    NSLog(@"Number of descriptors: %d", pcd->count);
    
}


@end
