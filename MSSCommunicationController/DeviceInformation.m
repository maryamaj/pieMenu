//
//  DeviceInformation.m
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "DeviceInformation.h"

@implementation DeviceInformation

@synthesize contactDescriptorByteValue = _contactDescriptorByteValue;
@synthesize ipStrLength = _ipStrLength;
@synthesize ipAddr = _ipAddr;

-(DeviceInformation *) initWithCDByteValue:(unsigned char)contactDescriptorByteValue andIp:(NSString *)ipAddr{

    self = [super init];
    
    if(self){
    
        self.contactDescriptorByteValue = contactDescriptorByteValue;
        self.ipAddr = ipAddr;
        self.ipStrLength = [ipAddr lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
    }
    
    return self;

}

+(DeviceInformation *) deviceInfoWithCDByteValue:(unsigned char)contactDescriptorByteValue andIp:(NSString *)ipAddr{

    return [[DeviceInformation alloc] initWithCDByteValue:contactDescriptorByteValue andIp:ipAddr];

}

+(DeviceInformation *) deviceInfoFromData:(NSData *)data {

    char* bytes =(char *) [data bytes];
    char cdByteValue = bytes[0];
    char ipStrLength = bytes[1];
    
    NSString* ipAddr = nil;
    
    char* string = malloc(ipStrLength+1*sizeof(unsigned char));
    if(string){
        for (int i = 2; i< 2+ipStrLength; i++) {
            
            string[i-2] = bytes[i];
        }
        string[ipStrLength] = '\0';
    
        ipAddr = [NSString stringWithCString:string encoding:NSASCIIStringEncoding];
        free(string);
    }
    
    return [DeviceInformation deviceInfoWithCDByteValue:cdByteValue andIp:ipAddr];
}


-(NSData *) data{

    NSData* data = nil;
    unsigned char* bytes = malloc(2+self.ipStrLength*sizeof(char));
    if(bytes){
        
        bytes[0] = self.contactDescriptorByteValue;
        bytes[1] = self.ipStrLength;
        
        const unsigned char *ipAddr = (unsigned char *) [self.ipAddr cStringUsingEncoding:NSASCIIStringEncoding];
        
        for(int i=0; i < self.ipStrLength ; i++){
            
            bytes[2+i] = ipAddr[i];
        }
        
        int lenght = 2 + self.ipStrLength;
        
        data = [NSData dataWithBytes:bytes length:lenght];
        
        free(bytes);
    }
    
    return data;
    

}
@end
