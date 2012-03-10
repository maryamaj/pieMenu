//
//  CodeineMessage.m
//  pieMenu
//
//  Created by Tommaso Piazza on 3/9/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "CodeineMessage.h"

@implementation CodeineMessage

@synthesize msgType = _msgType;
@synthesize subType = _subType;


-(CodeineMessage *) initWithType:(_t_CMSG) msgType andSubType:(unsigned char) subType{

    self = [super init];
    if(self){
        
        self.msgType = msgType;
        self.subType = subType;
    }
    
    return self;
}

+(CodeineMessage *) messageFromData:(NSData*) data{

    const unsigned char* bytes = [data bytes];

    _t_CMSG msgType = bytes[0];
    unsigned char subType = bytes[1];
    
    return [[CodeineMessage alloc] initWithType:msgType andSubType:subType];
}

-(NSData *) data{

    unsigned char bytes[2];
    
    bytes[0] = self.msgType;
    bytes[1] = self.subType;
    
    NSData* data = [NSData dataWithBytes:bytes length:2*sizeof(unsigned char)];
    
    return data;
}


@end
