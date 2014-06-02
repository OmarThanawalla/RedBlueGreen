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
@property (strong, nonatomic) NSArray * color;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.word = [NSArray arrayWithObjects:@"red", @"green", @"blue", nil];
    self.color = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
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
    NSString * myWord = self.word[r];
    
    //select the color of the word
    int s = arc4random() % 3;
    
    UIColor * myColor = self.color[s];
    
    
    //assignWord
    [self assignWord:myWord withColor:myColor];
}

-(void)assignWord: (NSString* ) wrd
        withColor: (UIColor *) clr
{
    self.wordFlash.text = wrd;
    self.wordFlash.textColor = clr;
    
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
