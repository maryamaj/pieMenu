//
//  ContactDescriptor.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/24/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "MSSCContactDescriptor.h"

@implementation MSSCContactDescriptor

@synthesize byteValue = _byteValue;
@synthesize positionX = _positionX;
@synthesize positionY = _positionY;
@synthesize orientation = _orientation;

+(MSSCContactDescriptor *) descriptorFromStruct:(ContactDescriptor) cd
{
 
    MSSCContactDescriptor* msscd = [[MSSCContactDescriptor alloc] initWithByteValue:cd.byteValue positionX:cd.positionX positionY:cd.positionY orientation:cd.orientation/10.0f];
    
    return msscd;

}

+ (MSSCContactDescriptor *) descriptorWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle{
    
    MSSCContactDescriptor* msscd = [[MSSCContactDescriptor alloc] initWithByteValue:byteValue positionX:posX positionY:posY orientation:angle]; 
    
    return msscd;
}


-(MSSCContactDescriptor *) initWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle{

    self = [super init];
    
    if(self){
    
        self.byteValue = byteValue;
        self.positionX = posX;
        self.positionY = posY;
        self.orientation = angle;
    }
    
    return self;
    
}

@end
