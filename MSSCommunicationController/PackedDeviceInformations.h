//
//  PackedDeviceInformations.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInformation.h"

@interface PackedDeviceInformations : NSObject
{
    NSArray* _devices;
    unsigned char _count;
}

@property (nonatomic, strong) NSArray* devices;
@property (nonatomic, readonly) unsigned char count;

+(PackedDeviceInformations *) packedDeviceInformationsFromData:(NSData *) data;
+(PackedDeviceInformations *) packedDeviceInformationsWithDIArray:(NSArray *) devices;
-(PackedDeviceInformations *) initWithDIArray:(NSArray *) devices;
-(NSData *) data;

@end
