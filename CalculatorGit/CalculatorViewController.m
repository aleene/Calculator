//
//  CalculatorViewController.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
/*  declaration of private instance variables
 */
/*  boolean, which is either YES or NO
    long variable names is encouraged, Xcode helps typing
 */
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

@end

@implementation CalculatorViewController
/*  add the name of the instance variable (_display):
    @synthesize creates the setter and the getter
    when the storyboard gets loaded by the stroryboard calles the setter
 */
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

/*  All original methods in the template have been deleted 
 */

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
    NSString *digit = [sender currentTitle];
/*  %@ is for strings 
    NSLog(@"digit pressed = %@", digit);
 */
    if (self.userIsInTheMiddleOfEnteringANumber) {
        
    self.display.text = [self.display.text stringByAppendingString:digit];
/*  which is short for:
    UILabel *myDisplay = self.display; // the same as: [self display]
    NSString *currentText = myDisplay.text; //[myDisplay text] for getters use the dot-notation!
    NSString *newText = [currentText stringByAppendingString:digit]; // add a string to another string
    myDisplay.text = newText; // use the setter for this:[myDisplay setText:newText];
 */
    }
    else { // the user starts off a new number
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)operationPressed:(id)sender {
}
- (IBAction)enterPressed {
}

@end
