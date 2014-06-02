//
//  ViewController.m
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray * word;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.word = [NSArray arrayWithObjects:@"red", @"green", @"blue", nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(createWordFlash)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)createWordFlash
{
    //select the word
    int r = arc4random() % 3;
    
    NSLog(@"r: %i", r);
    
    NSString * myWord = self.word[r];
    
    
    //select the color of the word
    
    
    //assignWord
    [self assignWord:myWord];
}

-(void)assignWord: (NSString* ) wrd
{
    self.wordFlash.text = wrd;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushRed:(id)sender {
}

- (IBAction)pushGreen:(id)sender {
}

- (IBAction)pushBlue:(id)sender {
}
@end
