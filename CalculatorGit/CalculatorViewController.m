//
//  CalculatorViewController.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"             

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize equationLabel = _equationLabel; 
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{   
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {               
        if ([sender.currentTitle isEqualToString:@"."]) {   
            NSRange range = [self.display.text rangeOfString:@"."];
            if (range.location == NSNotFound)                     
                self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];            
        }
        else if ([sender.currentTitle isEqualToString:@"+/-"])
            self.display.text = [@"-" stringByAppendingString:self.display.text];
        else                                                                   
            self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    }
    else { 
        self.display.text = sender.currentTitle;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.equationLabel.text = [self.equationLabel.text stringByAppendingFormat:@" %@",self.display.text];

}
- (IBAction)clearPressed
{
    [self.brain clear];
    self.display.text = @"0";
    self.equationLabel.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)clearError
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([self.display.text length] > 1) { 
            self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        }
        else
        {
            self.display.text = @"0";
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
}

- (IBAction)operationPressed:(UIButton * )sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    self.equationLabel.text = [self.equationLabel.text stringByAppendingFormat:@" %@ = %G",sender.currentTitle, result];
}

- (IBAction)changeSignPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) 
        [self digitPressed:sender];
    else 
        [self operationPressed:sender];
}

- (void)viewDidUnload {
    [self setEquationLabel:nil];
    [super viewDidUnload];
}
@end
