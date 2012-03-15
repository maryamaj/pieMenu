//
//  DeviceInformation.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInformation : NSObject
{
    unsigned char _contactDescriptorByteValue;
    unsigned char _ipStrLength;
    NSString* _ipAddr;
    
}

@property (nonatomic, assign) unsigned char contactDescriptorByteValue;
@property (nonatomic, assign) unsigned char ipStrLength;
@property (nonatomic, strong) NSString* ipAddr;

+(DeviceInformation *) deviceInfoWithCDByteValue:(unsigned char) contactDescriptorByteValue andIp:(NSString *) ipAddr;
+(DeviceInformation *) deviceInfoFromData:(NSData *) data;
-(DeviceInformation *) initWithCDByteValue:(unsigned char) contactDescriptorByteValue andIp:(NSString *) ipAddr;
-(NSData *) data;

@end
