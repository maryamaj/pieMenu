//
//  MyPieMenuController.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/27/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "pieMenuViewController.h"
#import "MSSCommunicationController.h"
#import "MSSCContactDescriptor.h"
#import "utils.h"

@interface MyPieMenuController : pieMenuViewController  <MSSCommunicationProtocol>
{

    unsigned char _byteValue;
    NSMutableArray* _cArray;
    MSSCContactDescriptor* _menuDevice;

}

@property (nonatomic) unsigned char byteValue;
@property (strong, nonatomic) NSMutableArray *cArray;
@property (strong, nonatomic) MSSCContactDescriptor *menuDevice;

-(float) dotProd:(CGPoint)v1 v2:(CGPoint) v2;
-(void) triggerWithDescriptor:(MSSCContactDescriptor *) cDesc;

@end
