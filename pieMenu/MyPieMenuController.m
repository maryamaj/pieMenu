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
    
    if([self.cArray count] == 1 && ((MSSCContactDescriptor *)[self.cArray objectAtIndex:0]).byteValue == self.byteValue)
        [self deseletSlice:_selectedSlice];
    
    for(int i  = 0; i < [self.cArray count]; i++){
    
        MSSCContactDescriptor  *cDesc = [self.cArray objectAtIndex:i];
        if(cDesc.byteValue != self.byteValue){
            
            [self triggerWithDescriptor:cDesc];
        }
        
    }

}

-(void) triggerWithDescriptor:(MSSCContactDescriptor *) cDesc{

    float degreesPerSlice = 1.0*(180/slicesPerEmiClicle(_slices));
    
    float angle_d = [MSSCContactDescriptor orientationOfDescriptor:cDesc relativeToDescriptor:self.menuDevice];
    int slice = -1;
    if(angle_d != 0.0)
         slice = floor(angle_d/degreesPerSlice);
    
    UIColor* color;
    
    if(angle_d > 0.0 && angle_d < 90.0) 
        color = [UIColor redColor];
    if(angle_d > 90.0 && angle_d < 180.0)
         color = [UIColor greenColor];
    if(angle_d > 180.0 && angle_d < 270.0)
        color = [UIColor blueColor];
    if(angle_d > 270.0 && angle_d < 360.0)
        color = [UIColor orangeColor];
    
    [self deseletSlice:_selectedSlice];
    [self selectSlice:slice withColor:color];
    
}

-(float) dotProd:(CGPoint)v1 v2:(CGPoint) v2{

    return ((v1.x*v2.x)+(v1.y*v2.y));

} 
@end
