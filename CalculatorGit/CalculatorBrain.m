//
//  CalculatorBrain.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

/*  The brain needs a stack, which can be implemented with an array
    a mutable array allows you to add things
    strong matters as it instructs the compiler
 */
@property (nonatomic,strong) NSMutableArray *operandStack;
    
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

/*  -operandStack is the  getter for operandStack
    Never use the instance variables outside the setter and getters
    Synthesize never allocates something, only creates the necessary space for the pointer
 */
- (NSMutableArray *)operandStack {
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

/* the example setter for the operandStack
    deleted as it is created as such by @synthesize
- (void)setOperandStack:(NSMutableArray *)operandStack {
        _operandStack = operandStack;
}
 */

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject]; // peek at last object
    if (operandObject ) [self.operandStack removeLastObject]; // be careful that we do not remove an non-existing object
    return [operandObject doubleValue];
}

- (void)pushOperand:(double)operand {
/*  Note that the stack does not work without it has been created!!!
    This call will however not give an error when it is not there.
    Properties start out as nil.
    operand must be wrapped in an object.
 */
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}
- (double)performOperation:(NSString *)operation {
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double part2 = [self popOperand];
        result = [self popOperand] - part2;
    } else if ([@"/" isEqualToString:operation]) {
        double part2 = [self popOperand];
        result = [self popOperand] / part2;
    }
    [self pushOperand:result]; // add result to the stack for the next operation
    
    return result;
}
@end
