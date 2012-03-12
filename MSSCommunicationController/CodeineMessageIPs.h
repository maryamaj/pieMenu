//
//  CodeineMessageIPs.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "CodeineMessage.h"
#import "PackedDeviceInformations.h"

@interface CodeineMessageIPs : CodeineMessage
{
    PackedDeviceInformations* _pdi;
}

@property (nonatomic, copy) PackedDeviceInformations* pdi;

+(CodeineMessageIPs *) messageOfTypeGet;
+(CodeineMessageIPs *) messageOfTypeSetWithPDI:(PackedDeviceInformations *) pdi;
+(CodeineMessageIPs *) messageFromData:(NSData *) data;
-(id) initMessageOfTypeGet;
-(id) initMessageOfTypeSetWithPDI:(PackedDeviceInformations *) pdi;
-(NSData*) data;

@end
