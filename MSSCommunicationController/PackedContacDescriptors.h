//
//  PackedContacDescriptors.h
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSCContactDescriptor.h"

@interface PackedContacDescriptors : NSObject
{
    unsigned char _count;
    NSArray* _contacs;
}

@property (nonatomic, readonly) unsigned char count;
@property (nonatomic, copy) NSArray* contacs;

-(PackedContacDescriptors *) initWithCDArray:(NSArray *) contacDescriptorsArray;
+(PackedContacDescriptors *) packedContactDescriptorsWithCDArray:(NSArray *) contacDescriptorsArray;
+(PackedContacDescriptors *) packedContactDescriptorsFromData:(NSData *) data;
-(NSData *) data;
-(int) size;

@end
