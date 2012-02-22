//
//  pieSlice.m
//  pieMenu
//
//  Created by Tommaso Piazza on 2/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "pieSliceView.h"
#import "utils.h"

@implementation pieSliceView

+ (pieSliceView *) sliceWithFrame:(CGRect) frame angle:(CGFloat) angle
{
    pieSliceView* newSlice = [[pieSliceView alloc] initWithFrame:frame angle:angle];
    return newSlice;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame angle:(CGFloat) angle
{

    if(self = [self  initWithFrame:frame]){
        
        _angle = angle;
        _lineWidth = 5.0;
        _color = [[UIColor yellowColor] CGColor];
    
    }
    
    return self;
    
    
}
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(ctx, CGColorGetComponents(_color));
    
    CGContextFillPath(ctx);
    
    UIBezierPath *thePath = [UIBezierPath bezierPath];
    thePath.lineWidth = _lineWidth;
    
    _center = CGPointMake(rect.size.width, rect.size.height);
    
    [thePath moveToPoint:_center];
    
    [thePath addArcWithCenter:_center radius:rect.size.width startAngle:M_PI endAngle:M_PI+degreesToRadians(_angle)clockwise:YES];
    
    //[thePath addLineToPoint:CGPointMake(0, rect.size.height)];
    //[thePath moveToPoint:_center];
    [thePath closePath];
    //[thePath stroke];
    [thePath fill];
    
    /*
    CGRect p = CGRectMake(0, 0, 10, 10);
    CGContextAddEllipseInRect(ctx, p);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor greenColor] CGColor]));
    CGContextFillPath(ctx);
    
    CGRect q = CGRectMake(self.center.x, self.center.y, 10, 10);
    CGContextAddEllipseInRect(ctx, q);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor redColor] CGColor]));
    CGContextFillPath(ctx);
    
    CGRect r = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 10, 10);
    CGContextAddEllipseInRect(ctx, r);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor brownColor] CGColor]));
    CGContextFillPath(ctx);
     */
    
}

- (void) changeColor:(UIColor *) newColor {
    
    _color = [newColor CGColor];
    [self setNeedsDisplay];

}
@end
