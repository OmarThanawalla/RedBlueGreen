//
//  ViewController.m
//  RedBlueGreen
//
//  Created by Omar Thanawalla on 6/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer * gameTimer;
@property (strong, nonatomic) NSArray * word;
@property (strong, nonatomic) NSArray * color;
@property (assign) int correctAns;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Init words, colors
    self.word = [NSArray arrayWithObjects:@"red", @"green", @"blue", nil];
    self.color = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    //Begin Timer
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(createWordFlash)
                                   userInfo:nil
                                    repeats:YES];
    //The game is live
    self.continuePlaying = 1;
}

-(void)createWordFlash
{
    if(!self.continuePlaying)
    {
        //kill the game (ran out of time)
        [self killGame];
    }
    //select the word
    int r = arc4random() % 3;
    NSString * myWord = self.word[r];
    self.correctAns = r;
    
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
    
    //The user must save himself
    self.continuePlaying = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushRed:(id)sender {
    if(self.correctAns == 0)
    {
        //correct push
        self.continuePlaying = 1;
        [self createWordFlash];
    }else{
        //lose, kill the game (incorrect push)
        [self killGame];
    }
}

- (IBAction)pushGreen:(id)sender {
    if(self.correctAns == 1)
    {
        self.continuePlaying = 1;
        [self createWordFlash];
    }else{
        [self killGame];
    }
    
}

- (IBAction)pushBlue:(id)sender {
    if(self.continuePlaying == 2)
    {
        self.continuePlaying = 1;
        [self createWordFlash];
    }else{
        [self killGame];
    }
    
}

-(void)killGame
{
    [self.gameTimer invalidate];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] ;
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}


@end
