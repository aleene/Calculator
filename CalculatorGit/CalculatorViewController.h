//
//  CalculatorViewController.h
//  CalculatorGit
//
//  Created by Arnaud Leene on 31/1/12.
//  Copyright (c) 2012 MicroContent Musings - Hovering Above. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

/*  storage is set as "weak" as it already has strong pointers to it in the Storyboard.
    outlets are always weak!!!
    nonatomic means that it is not threadsafe.
    IBOutlet is typedeffed to nothing. It is just for Xcode, it is not used by the compiler.
    Type of "display" is a UILabel *: a pointer.
    Note the round circle in the gutter, mouse over to see where it is connected to
 */
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;

@end
