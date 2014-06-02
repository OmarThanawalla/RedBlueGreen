//
//  ViewController.h
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *wordFlash;
@property (assign) int continuePlaying;


- (IBAction)pushRed:(id)sender;
- (IBAction)pushGreen:(id)sender;
- (IBAction)pushBlue:(id)sender;



@end
