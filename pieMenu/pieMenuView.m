//
//  pieMenuView.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/16/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "pieMenuView.h"
#import "utils.h"

@implementation pieMenuView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andSlices:(int) numSlices
{
    self = [super initWithFrame:frame];
    if (self) {
        _degrees = 1.0*(180/slicesPerEmiClicle(numSlices));
        CGFloat sliceHeight = frame.size.height/2 *  sin(degreesToRadians(_degrees));
        _sliceRect = CGRectMake(0, frame.size.height/2-sliceHeight, frame.size.width/2, sliceHeight);
        _slices = [NSMutableArray arrayWithCapacity:numSlices];
        
        for(int i  = 0; i < numSlices; i++){
            [_slices addObject:[pieSliceView sliceWithFrame:_sliceRect angle:_degrees]];
            [self addSubview:[_slices objectAtIndex:i]];
            CGAffineTransform toCenter = CGAffineTransformMakeTranslation(_sliceRect.size.width/2, _sliceRect.size.height/2);
            CGAffineTransform rot = CGAffineTransformMakeRotation(degreesToRadians(_degrees*i));
            
            CGAffineTransform comb = CGAffineTransformConcat(rot, toCenter);
            CGAffineTransform backToOrigin = CGAffineTransformMakeTranslation(-_sliceRect.size.width/2, -_sliceRect.size.height/2);
            CGAffineTransform comb2 = CGAffineTransformConcat(backToOrigin, comb );
            UIView* view = [_slices objectAtIndex:i];
            view.transform=comb2;

        }
    }
    
    return self;
}

     
- (UIBezierPath *) pathFrom:(CGPoint) start to:(CGPoint) end
{
    UIBezierPath*    aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5;
    [aPath moveToPoint:start];
    [aPath addLineToPoint:end];
    [aPath closePath];
    

    return aPath;
}
     

@end
