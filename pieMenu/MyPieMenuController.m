//
//  MyPieMenuController.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/27/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "MyPieMenuController.h"

@implementation MyPieMenuController

@synthesize byteValue = _byteValue;
@synthesize cArray = _cArray;
@synthesize menuDevice = _menuDevice;


-(void) newContacs:(NSDictionary *)contacDictionary{

    
    self.cArray = [NSMutableArray arrayWithArray:[contacDictionary allValues]];
    
    for(int i  = 0; i < [self.cArray count]; i++){
    
        MSSCContactDescriptor  *cDesc = [self.cArray objectAtIndex:i];
        if(cDesc.byteValue == self.byteValue){
        
            self.menuDevice = cDesc;
        }
    }
    
    
    for(int i  = 0; i < [self.cArray count]; i++){
    
        MSSCContactDescriptor  *cDesc = [self.cArray objectAtIndex:i];
        if(cDesc.byteValue != self.byteValue){
            
            [self triggerWithDescriptor:cDesc];
        }
    }

}

-(void) triggerWithDescriptor:(MSSCContactDescriptor *) cDesc{

    cDesc.positionX = self.menuDevice.positionX - cDesc.positionX;
    cDesc.positionY = self.menuDevice.positionY - cDesc.positionY;
    
    int distance = sqrt(cDesc.positionX*cDesc.positionX + cDesc.positionY*cDesc.positionY);
    
    short quadrant = -1;
    
    if( cDesc.positionX > 0 && cDesc.positionY > 0)
        quadrant = 1;
    else if( cDesc.positionX > 0 && cDesc.positionY < 0)
        quadrant = 2;
    else if( cDesc.positionX < 0 && cDesc.positionY < 0)
        quadrant = 3;
    else if( cDesc.positionX < 0 && cDesc.positionY > 0)
        quadrant = 0;
    
    float degreesPerSlice = 1.0*(180/slicesPerEmiClicle(_slices));
    
    CGPoint normalized = CGPointMake(cDesc.positionX/distance, cDesc.positionY/distance);
    CGPoint versor;
    
    float angle_d;
    
    switch (quadrant) {
        case 0:
            versor = CGPointMake(-1, 0);
            angle_r = acos([self dotProd:normalized v2:versor]);
            break;
        case 1:
            versor = CGPointMake(0, 1);
            angle_r = M_PI/2 + acos([self dotProd:normalized v2:versor]);
            break;
        case 2:
            versor = CGPointMake(1, 0);
            angle_r = M_PI + acos([self dotProd:normalized v2:versor]);
            break;
        case 3:
            versor = CGPointMake(0, -1);
            angle_r = M_PI*3/2 + acos([self dotProd:normalized v2:versor]);
            break
        default:
            break;
    }
    
    float angle_d = radiansToDegrees(angle_r);
    int slice = ceil(angle_d/degreesPerSlice);
    
    [self deseletSlice:_selectedSlice];
    [self selectSlice:slice];
    
}

-(float) dotProd:(CGPoint)v1 v2:(CGPoint) v2{

    return ((v1.x*v2.x)+(v1.y*v2.y));

} 
@end
