//
//  PackedContacDescriptors.m
//  pieMenu
//
//  Created by Tommaso Piazza on 3/10/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "PackedContacDescriptors.h"

@implementation PackedContacDescriptors
@synthesize count = _count;
@synthesize contacs = _contacs;

-(PackedContacDescriptors *) initWithCDArray:(NSArray *)contacDescriptorsArray{

    self = [super init];
    
    if (self) {
        
        self.contacs = contacDescriptorsArray;
        _count = self.contacs.count;
    }
    
    return self;
}

+(PackedContacDescriptors *) packedContactDescriptorsWithCDArray:(NSArray *)contacDescriptorsArray {

    return [[PackedContacDescriptors alloc] initWithCDArray:contacDescriptorsArray];

}

+(PackedContacDescriptors *) packedContactDescriptorsFromData:(NSData *)data {

    const unsigned char* bytes = [data bytes];
    
    unsigned char count = bytes[0];
    
    NSMutableArray* devices = [NSMutableArray arrayWithCapacity:count];
    
    int pos = 1;
    int length = sizeof(unsigned char)+3*(sizeof(int));
    for(int i = 0; i < count; i++){
        
        NSData* data = [NSData dataWithBytes:&(bytes[pos]) length:length];
        [devices insertObject:[MSSCContactDescriptor descriptorFromData:data]  atIndex:i];
        pos = pos + length;
        
    }
    
    return [PackedContacDescriptors packedContactDescriptorsWithCDArray:devices];

}

-(NSData *) data {

    unsigned char bytes[1];
    bytes[0] = self.count;
    
    NSMutableData* data = [NSData dataWithBytes:&(bytes[0]) length:sizeof(unsigned char)];
    
    for(int i = 0; i < self.count; i ++){
    
        MSSCContactDescriptor* cd = [_contacs objectAtIndex:i];
        
        [data appendData:[cd data]];
    
    }
    
    return data;
    
}

@end
