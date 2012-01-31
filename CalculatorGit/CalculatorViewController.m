//
//  CalculatorViewController.m
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController
/*  add the name of the instance variable (_display):
    @synthesize creates the setter and the getter
    when the storyboard gets loaded by the stroryboard calles the setter
 */
@synthesize display = _display;
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
    /*  %@ is for strings */
    NSLog(@"digit pressed= %@", digit);
}

@end
