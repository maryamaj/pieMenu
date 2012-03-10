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

-(id) initMessageOfTypeSetWithPCD:(PackedDeviceInformations *)pdi {
    
    
    self = [super initWithType:kMSGIPs andSubType:kMSGSetIPs];
    if(self){
        
        self.pdi = pdi; 
    }
    
    return  self;
}

+(CodeineMessageIPs *) messageOfTypeGet{
    
    return [[CodeineMessageIPs alloc] initMessageOfTypeGet];
}

+(CodeineMessageIPs *) messageOfTypeSetWithPCD:(PackedDeviceInformations *)pdi {
    
    return [[CodeineMessageIPs alloc] initMessageOfTypeSetWithPDI:pdi];
}

+(CodeineMessageIPs *) messageFromData:(NSData *)data{
    
    CodeineMessageIPs* cmIPs =(CodeineMessageIPs *) [super messageFromData:data];
    
    const unsigned char* bytes = [data bytes];
    
    int pos = 2*sizeof(unsigned char);
    NSData* pdiData = [NSData dataWithBytes:&(bytes[pos]) length:data.length];
    
    PackedDeviceInformations* pdi = [PackedDeviceInformations packedDeviceInformationsFromData:pdiData];
    cmIPs.pdi = pdi;
    
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
