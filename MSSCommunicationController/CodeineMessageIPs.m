//
//  CodeineMessageIPs.m
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "CodeineMessageIPs.h"

@implementation CodeineMessageIPs

@synthesize pdi = _pdi;

-(id) initMessageOfTypeGet{
    
    self = [super initWithType:kMSGIPs andSubType:kMSGGetIPs];
    
    if(self){
        
        _pdi = nil;
    }
    
    return self;
    
}

-(id) initMessageOfTypeSetWithPDI:(PackedDeviceInformations *) pdi{
    
    
    self = [super initWithType:kMSGIPs andSubType:kMSGSetIPs];
    if(self){
        
        _pdi = pdi; 
    }
    
    return  self;
}

+(CodeineMessageIPs *) messageOfTypeGet{
    
    return [[CodeineMessageIPs alloc] initMessageOfTypeGet];
}

+(CodeineMessageIPs *) messageOfTypeSetWithPDI:(PackedDeviceInformations *) pdi{
    
    return [[CodeineMessageIPs alloc] initMessageOfTypeSetWithPDI:pdi];
}

+(CodeineMessageIPs *) messageFromData:(NSData *)data{
    
    CodeineMessageIPs* cmIPs;
    
    const unsigned char* bytes = [data bytes];
    
    if(bytes[1] == kMSGGetIPs){
    
        cmIPs = [CodeineMessageIPs messageOfTypeGet];
    }
    else if(bytes[1] == kMSGSetIPs){
        
        int pos = 2*sizeof(unsigned char);
        NSData* pdiData = [NSData dataWithBytes:&(bytes[pos]) length:data.length];
        
        PackedDeviceInformations* pdi = [PackedDeviceInformations packedDeviceInformationsFromData:pdiData];
        cmIPs = [CodeineMessageIPs messageOfTypeSetWithPDI:pdi];
    }
    
    return cmIPs;
    
}

-(NSData *) data{
    
    NSMutableData* data = [NSMutableData data];
    [data appendData:[super data]];
    
    if(self.subType == kMSGGetIPs)
    /* Do nothing */ ;
    else 
        if(self.subType == kMSGSetIPs){
            
            [data appendData:[self.pdi data]];
        } 
    
    return data;
    
}

@end
