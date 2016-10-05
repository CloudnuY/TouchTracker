//
//  CLDDrawView.m
//  TouchTracker
//
//  Created by Cloud on 2016/10/5.
//  Copyright © 2016年 Cloud. All rights reserved.
//

#import "CLDDrawView.h"
#import "CLDLine.h"

@interface CLDDrawView ()

@property (nonatomic, strong) CLDLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end


@implementation CLDDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        // self.multipleTouchEnabled = YES; //多点触摸
    }
    return self;
}

- (void)strokeLine:(CLDLine *)line {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (CLDLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    if (self.currentLine) {
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    
    CGPoint location = [t locationInView:self];
    self.currentLine = [[CLDLine alloc] init];
    self.currentLine.begin = location;
    self.currentLine.end = location;
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    
    self.currentLine.end = location;
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.finishedLines addObject:self.currentLine];
    
    self.currentLine = nil;
    
    [self setNeedsDisplay];
}

@end
