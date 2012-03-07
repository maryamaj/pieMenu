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

#pragma mark -
#pragma mark Class Utility Methods

+(float) distanceFromDescriptor:(MSSCContactDescriptor*) a toDescriptor:(MSSCContactDescriptor *) b{    
    
    float positionX = a.positionX - b.positionX;
    float positionY = b.positionY - a.positionY;
    
    float distance = sqrt(positionX*positionX + positionY*positionY);
    
    return distance;

}

+(CGPoint) positionOfDescriptor:(MSSCContactDescriptor *) desc relativeToDescriptor:(MSSCContactDescriptor *) origin{

    float positionX = origin.positionX - desc.positionX;
    float positionY = desc.positionY - origin.positionY;
    
    return CGPointMake(positionX, positionY);

}

+(float) orientationOfDescriptor:(MSSCContactDescriptor *) desc relativeToDescriptor:(MSSCContactDescriptor *) origin{
    
    float distance = [MSSCContactDescriptor distanceFromDescriptor:origin toDescriptor:desc];
    
    CGPoint relativeToOrigin = [MSSCContactDescriptor positionOfDescriptor:desc relativeToDescriptor:origin];
    
    short quadrant = -1;
    
    if( relativeToOrigin.x > 0 && relativeToOrigin.y > 0)
        quadrant = 1;
    else if( relativeToOrigin.x > 0 && relativeToOrigin.y < 0)
        quadrant = 2;
    else if( relativeToOrigin.x < 0 && relativeToOrigin.y < 0)
        quadrant = 3;
    else if( relativeToOrigin.x < 0 && relativeToOrigin.y > 0)
        quadrant = 0;

    
    CGPoint normalized = CGPointMake(relativeToOrigin.x/distance, relativeToOrigin.y/distance);
    CGPoint versor;
    
    float angle_r;
    
    switch (quadrant) {
        case 0:
            versor = CGPointMake(-1, 0);
            angle_r = acos([MSSCContactDescriptor dotProd:normalized v2:versor]);
            break;
        case 1:
            versor = CGPointMake(0, 1);
            angle_r = M_PI/2 + acos([MSSCContactDescriptor dotProd:normalized v2:versor]);
            break;
        case 2:
            versor = CGPointMake(1, 0);
            angle_r = M_PI + acos([MSSCContactDescriptor dotProd:normalized v2:versor]);
            break;
        case 3:
            versor = CGPointMake(0, -1);
            angle_r = M_PI*3/2 + acos([MSSCContactDescriptor dotProd:normalized v2:versor]);
            break;
        default:
            break;
    }
    
    float angle_d = MSSC_radiansToDegrees(angle_r);
    
    return angle_d;

    
}

+(float) dotProd:(CGPoint)v1 v2:(CGPoint) v2{
    
    return ((v1.x*v2.x)+(v1.y*v2.y));
    
} 

@end
