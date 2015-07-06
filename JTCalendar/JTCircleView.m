//
//  JTCircleView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCircleView.h"

// http://stackoverflow.com/questions/17038017/ios-draw-filled-circles

@implementation JTCircleView

void drawLine(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor whiteColor];
    self.shouldHaveBorder = YES;
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextFillRect(ctx, rect);
    
    rect = CGRectInset(rect, 1.0, 1.0);
    
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    CGContextAddRect(ctx, rect);
    CGContextFillRect(ctx, rect);
    
    if (self.shouldHaveBorder) {
        drawLine(ctx, CGPointMake(rect.origin.x, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y), [UIColor blackColor].CGColor);
        drawLine(ctx, CGPointMake(rect.origin.x + rect.size.width, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height), [UIColor blackColor].CGColor);
        drawLine(ctx, CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height), CGPointMake(rect.origin.x, rect.origin.y + rect.size.height), [UIColor blackColor].CGColor);
        drawLine(ctx, CGPointMake(rect.origin.x, rect.origin.y + rect.size.height), CGPointMake(rect.origin.x, rect.origin.y), [UIColor blackColor].CGColor);
    }
    
    CGContextFillPath(ctx);
}

void drawLine(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color)
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5f, startPoint.y + 0.5f);
    CGContextAddLineToPoint(context, endPoint.x + 0.5f, endPoint.y + 0.5f);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}

@end
