//
//  CodeineContactsMessage.m
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "CodeineMessageContacts.h"

@implementation CodeineMessageContacts
@synthesize pcd = _pcd;

-(id) initMessageOfTypeGet{

    self = [super initWithType:kMSGContacts andSubType:kMSGGetContacts];
    
    if(self){
    
        _pcd = nil;
    }
    
    return self;

}

-(id) initMessageOfTypeSetWithPCD:(PackedContacDescriptors *)pcd {


    self = [super initWithType:kMSGContacts andSubType:kMSGSetContacts];
    if(self){
    
        _pcd = pcd; 
    }

    return  self;
}

+(CodeineMessageContacts *) messageOfTypeGet{

    return [[CodeineMessageContacts alloc] initMessageOfTypeGet];
}

+(CodeineMessageContacts *) messageOfTypeSetWithPCD:(PackedContacDescriptors *)pcd {

    return [[CodeineMessageContacts alloc] initMessageOfTypeSetWithPCD:pcd];
}

+(CodeineMessageContacts *) messageFromData:(NSData *)data{

    CodeineMessageContacts* cmC;
    
    const unsigned char* bytes = [data bytes];
    
    if(bytes[1] == kMSGGetContacts){
    
        cmC = [CodeineMessageContacts messageOfTypeGet];
    }
    else if(bytes[1] == kMSGSetContacts){
        

        int pos = 2*sizeof(unsigned char);
        NSData* pcdData = [NSData dataWithBytes:&(bytes[pos]) length:data.length];
        
        PackedContacDescriptors* pcd = [PackedContacDescriptors packedContactDescriptorsFromData:pcdData];
        cmC = [CodeineMessageContacts messageOfTypeSetWithPCD:pcd];
    
    }
    return cmC;
    
}

-(NSData *) data{

    NSMutableData* data = [NSMutableData data];
     [data appendData:[super data]];
    
    if(self.subType == kMSGGetContacts)
        /* Do nothing */ ;
    else 
        if(self.subType == kMSGSetContacts){
        
            [data appendData:[self.pcd data]];
        } 
        
    return data;
    
}


@end
