//
//  CalculatorViewController.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorViewController.h"
// import the definitions of the CalculatorBrain class so we can use them
#import "CalculatorBrain.h"             
/*  declaration of private instance variables */
@interface CalculatorViewController ()

/*  boolean, which is either YES or NO
    long variable names is encouraged, Xcode helps typing
 */
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController
/*  add the name of the instance variable (_display):
    @synthesize creates the setter and the getter
    when the storyboard gets loaded by the stroryboard calles the setter
 */
@synthesize display = _display;
@synthesize equationLabel = _equationLabel;      //  for Assignment 1-4
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

/*                                  All original methods in the template have been deleted              */


- (CalculatorBrain *)brain
{   
/*  lazy instantiation for brain, only create it when it is called
    instantiate properties only in the getter
 */
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

/*  method declaration digitPressed:
    The return value is typedeffed to IBAction, which is void. It is used by Xcode.
    The argument of the method is the object that invoked the method.
    This has type "id", which means any object.
 */
- (IBAction)digitPressed:(UIButton *)sender {
/*  - (IBAction)digitPressed:(id)sender
    id changed to UIButton *, so that Xcode helps better with completion and
    limit possible erros
 */
/*  NSString *digit = [sender currentTitle];
    is currentTitle making a copy or giving a pointer???
    it is a getter, so we can suppress this code line
 */
    
/*  %@ is for strings 
    NSLog(@"digit pressed = %@", digit);
 */
    if (self.userIsInTheMiddleOfEnteringANumber) {               
        if ([sender.currentTitle isEqualToString:@"."])             // has a digit been pressed? 
        {   // using the hint 1 in assignment 1
            NSRange range = [self.display.text rangeOfString:@"."];
            if (range.location == NSNotFound) {                     // was this the first digit?
                self.display.text = [self.display.text stringByAppendingString:sender.currentTitle]; //[self.display setText:newDisplayText];
            }
        }
        else if ([sender.currentTitle isEqualToString:@"+/-"])
        {
            self.display.text = [@"-" stringByAppendingString:self.display.text];
            
        }
        else // the entered digit is not a dot
        {                                                                       
            self.display.text = [self.display.text stringByAppendingString:sender.currentTitle]; // was: [self.display setText:newDisplayText];
        }
        

/*  which is short for:
    UILabel *myDisplay = self.display; // the same as: [self display]
    NSString *currentText = myDisplay.text; //[myDisplay text] for getters use the dot-notation!
    NSString *newText = [currentText stringByAppendingString:digit]; // add a string to another string
    myDisplay.text = newText; // use the setter for this:[myDisplay setText:newText];
 */
    }
    else { // the user starts off a new number
        // we do not check for new leading zero's. One could add an if to check for this
        self.display.text = sender.currentTitle;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed
{
    // enterPressed should add the operand to the stack
    [self.brain pushOperand:[self.display.text doubleValue]];
    // if something is pushed on the stack, the user no longer types a number (we just entered it)
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
        // clear the display
        if ([self.display.text length] > 1) { 
            self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        }
        else
        {                                      // last number deleted? replace with 0 then
            self.display.text = @"0";
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
}

- (IBAction)operationPressed:(UIButton * )sender {
    // help the user and finish the number is needed
    // note that enterPressed only works here, if it appears after the definition of enterPressed
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    // do the operation from the title of the button (bad design)
    double result = [self.brain performOperation:sender.currentTitle];
    // create a string from the double, so we can display it
    // Note that this is sent to the class NSString
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    // change the display
    self.display.text = resultString;
    self.equationLabel.text = [self.equationLabel.text stringByAppendingFormat:@" %@ = %G",sender.currentTitle, result];
}

- (IBAction)changeSignPressed:(UIButton *)sender {
    /*  Assignment 1-Extra 3 : method and button added
     */
    if (self.userIsInTheMiddleOfEnteringANumber) 
    {                                               // if the user was typing a number let the digitPressed: method handle it
        [self digitPressed:sender];
    } else 
    {                                               // if the user is in operation mode let the operationPressed: method handle it
        [self operationPressed:sender];
    }
}

- (void)viewDidUnload {
    [self setEquationLabel:nil];
    [super viewDidUnload];
}
@end
