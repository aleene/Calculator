//
//  CalculatorBrain.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic,strong) NSMutableArray *operandStack;
    
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject]; 
    if (operandObject ) [self.operandStack removeLastObject]; 
    return [operandObject doubleValue];
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"]) 
    {
        result = [self popOperand] + [self popOperand];
    } 
    else if ([@"*" isEqualToString:operation]) 
    {
        result = [self popOperand] * [self popOperand];
    } 
    else if ([@"-" isEqualToString:operation]) 
    {
        double part2 = [self popOperand];
        result = [self popOperand] - part2;
    } 
    else if ([@"/" isEqualToString:operation]) 
    {
        double part2 = [self popOperand];
        if (part2 != 0.0) {
            result = [self popOperand] / part2;
        } else
        {
            return 0.0;
        }
    } 
    else if ([operation isEqualToString:@"sin"])
    {
        result = sin([self popOperand]);
    } 
    else if ([operation isEqualToString:@"cos"])
    {
        result = cos([self popOperand]);
    }
    else if ([operation isEqualToString:@"sqrt"])
    {
        double part2 = [self popOperand];
        if (part2 >= 0.0) {
            result = sqrt(part2);
        }
        else {
            result = 0.0;
        }
        
    }
    else if ([operation isEqualToString:@"+/-"])
    {
        result = - [self popOperand];
    }
    else if ([operation isEqualToString:@"π"])
    {
        result = acos(0.0) * 2.0;
    } 

    [self pushOperand:result];
    
    return result;
}

- (void)clear
{
    [self.operandStack removeAllObjects];
}
@end
