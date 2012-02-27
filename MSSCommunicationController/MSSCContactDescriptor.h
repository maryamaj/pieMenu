//
//  ContactDescriptor.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/24/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeineStructs.h"

@interface MSSCContactDescriptor : NSObject
{
    unsigned char _byteValue;

    int _positionX;
    int _positionY;
    float _orientation;
    
}

@property (atomic) unsigned char byteValue;
@property (atomic) int positionX;
@property (atomic) int positionY;
@property (atomic) float orientation;

+(MSSCContactDescriptor *) descriptorFromStruct:(ContactDescriptor) cd;
+(MSSCContactDescriptor *) descriptorWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle;


-(MSSCContactDescriptor *) initWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle;


@end

