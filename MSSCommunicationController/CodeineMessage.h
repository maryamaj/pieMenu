//
//  CodeineMessage.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/9/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _MSGSUBTYPE { kMSGSetContacts, kMSGSetIPs, kMSGGetContacts, kMSGGetIPs} _t_CMSGSUBTYPE;
typedef enum _MSG { kMSGContacts, kMSGIPs } _t_CMSG;

@interface CodeineMessage : NSObject
{
    _t_CMSG _msgType;
    unsigned char _subType;
}

@property (nonatomic, assign) _t_CMSG msgType;
@property (nonatomic, assign) unsigned char subType;

+(CodeineMessage *) messageFromData:(NSData*) data;
-(CodeineMessage *) initWithType:(_t_CMSG) msgType andSubType:(unsigned char) subType;
-(NSData *) data;

@end
