//
//  CodeineContactsMessage.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "CodeineMessage.h"
#import "PackedContacDescriptors.h"

@interface CodeineMessageContacts : CodeineMessage
{
    PackedContacDescriptors* _pcd;
}

@property (nonatomic, strong) PackedContacDescriptors* pcd;

+(CodeineMessageContacts *) messageOfTypeGet;
+(CodeineMessageContacts *) messageOfTypeSetWithPCD:(PackedContacDescriptors *) pcd;
+(CodeineMessageContacts *) messageFromData:(NSData *) data;
-(id) initMessageOfTypeGet;
-(id) initMessageOfTypeSetWithPCD:(PackedContacDescriptors *) pcd;
-(NSData*) data;

@end
