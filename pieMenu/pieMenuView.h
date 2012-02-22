//
//  pieMenuView.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/16/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pieSliceView.h"



@interface pieMenuView : UIView
{
    CGFloat _degrees;
    CGRect _sliceRect;
    NSMutableArray* _slices;
}

- (id)initWithFrame:(CGRect)frame andSlices:(int) numSlices;
- (UIBezierPath *) pathFrom:(CGPoint) start to:(CGPoint) end;
//-(void) pathFrom:(CGPoint) start to:(CGPoint) end inContext:(CGContextRef) ctx;

@end
