//
//  pieMenuViewController.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/22/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "pieMenuView.h"

@interface pieMenuViewController : UIViewController
{
    int _slices;
    int _selectedSlice;

}

@property (nonatomic) int selectedSlice;

- (id) initWithSlices:(int) slices;
-(void) selectSlice:(int) sliceNumber;
-(void) selectSlice:(int)sliceNumber withColor:(UIColor *) color;
-(void) deseletSlice:(int) sliceNumber;

@end
